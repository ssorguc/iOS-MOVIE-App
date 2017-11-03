//
//  TVShowDetailTableViewController.m
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "ActorCollectionView.h"
#import "SingleReviewTableViewCell.h"
#import "ActorCollectionViewCell.h"
#import "CrewMember.h"
#import "SingleReview.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <RestKit/RestKit.h>
#import "ReviewTableViewCell.h"
#import "MovieTrailerTableViewCell.h"
#import "Genre.h"
#import "ImageGalleryTableViewCell.h"
#import "CastTableViewCell.h"
#import "MovieDescriptionTableViewCell.h"
#import "TVShowDetailTableViewController.h"
#import "SeasonsTableViewCell.h"
#import "SingleSeason.h"
#import "TVShow.h"
#import "VideosCollection.h"
#import "Trailer.h"
#import "CastCollection.h"
#import "YTPlayerView.h"
#import "TVShowService.h"
#import "CrewMember.h"
#import "Actor.h"
@interface TVShowDetailTableViewController (){
    TVShow* selectedTVShow;
    TVShowService* tvShowService;
    VideosCollection* tvShowVideoCollection;
    Trailer* t;
    CastCollection* tvShowCast;
    NSMutableArray* writers;
    NSMutableArray* stars;
    NSMutableArray* director;
    NSString* yearsString;
    NSString* allWriters;
    NSString* allDirectors;
}
@end

@implementation TVShowDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([MovieTrailerTableViewCell class]) bundle:nil] forCellReuseIdentifier:movieTrailerCellReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([ImageGalleryTableViewCell class]) bundle:nil] forCellReuseIdentifier:imageGalleryReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([MovieDescriptionTableViewCell class]) bundle:nil] forCellReuseIdentifier:descriptionReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([CastTableViewCell class]) bundle:nil] forCellReuseIdentifier:castReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SeasonsTableViewCell class]) bundle:nil] forCellReuseIdentifier:seasonsReuseIdentifier];
    tvShowService = [[TVShowService alloc]init];
    [self loadPopularTVShows];
    [self loadTvShowTrailers];
    [self loadCast];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [[UITableViewCell alloc]init];
        if(indexPath.section == 0){
            return [self setUpTrailerCell:(MovieTrailerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:movieTrailerCellReuseIdentifier forIndexPath:indexPath] atIndexPath:indexPath];
        }
        else if (indexPath.section == 1){
            return [self setUpMovieDescriptionCell:(MovieDescriptionTableViewCell*)[tableView dequeueReusableCellWithIdentifier:descriptionReuseIdentifier forIndexPath:indexPath] atIndexPath:indexPath];
        }
        else if (indexPath.section == 2){
            return [self setUpSeasonsCell:(SeasonsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:seasonsReuseIdentifier forIndexPath:indexPath] atIndexPath:indexPath];
        }
        else if (indexPath.section == 3){
            return (ImageGalleryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:imageGalleryReuseIdentifier forIndexPath:indexPath];
        }
        else if (indexPath.section == 4){
            return [self setUpCastCollectionCell:(CastTableViewCell*)[tableView dequeueReusableCellWithIdentifier:castReuseIdentifier forIndexPath:indexPath] atIndexPath:indexPath];
        }
    return cell;
}
#pragma Custom cell setup
- (MovieTrailerTableViewCell*)setUpTrailerCell:(MovieTrailerTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    //Release date
    [df setDateFormat:@"d MMMM yyyy"];
    cell.releaseDateLabel.text = [df stringFromDate:selectedTVShow.firstAirDate];
    //Movie title
    cell.titleLabel.text = [self getTitleString];
    //Genres
    cell.genreLabel.text = [self getGenresString];
    //Trailer
    if(tvShowVideoCollection.videoResults.count != 0){
        t = [tvShowVideoCollection.videoResults objectAtIndex:0];
        NSDictionary *playerVars = @{@"playsinline" : @1};
        [cell.movieTrailerPlayer loadWithVideoId:t.key playerVars:playerVars];
        cell.durationLabel.text = @"";
    }
    return cell;
}
- (MovieDescriptionTableViewCell*)setUpMovieDescriptionCell:(MovieDescriptionTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.descriptionLabel.text = selectedTVShow.overview;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode: NSNumberFormatterRoundUp];
    cell.rateLabel.text = [formatter stringFromNumber:selectedTVShow.voteAverage];
    [self getWritersDirectorsStringForLabel];
    cell.writerLabel.text = allWriters;
    cell.directorLabel.text = allDirectors;
    return cell;
}
- (SeasonsTableViewCell*)setUpSeasonsCell:(SeasonsTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.seasonsNumLabel.text = [self getSeasonNumberString];
    cell.seasonsYearsLabel.text = [self getSeasonsYearsNumber];
    return cell;
}
-(CastTableViewCell*)setUpCastCollectionCell:(CastTableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath{
    cell.castCollectionView.dataSource = self;
    cell.castCollectionView.delegate = self;
    [cell.castCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ActorCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:actorReuseIdentifier];
    [cell.castCollectionView reloadData];
    return cell;
}
-(void)getWritersDirectorsStringForLabel{
    allWriters = @"";
    allDirectors = @"";
    NSInteger i = 1;
    for(CrewMember* crewTemp in tvShowCast.crew){
        if([crewTemp.job isEqualToString:@"Director"]){
            allDirectors = [allDirectors stringByAppendingString:crewTemp.name];
            allDirectors = [allDirectors stringByAppendingString:@", "];
            
        }
        if([crewTemp.job isEqualToString:@"Writer"]){
            allWriters = [allWriters stringByAppendingString:crewTemp.name];
            allWriters = [allWriters stringByAppendingString:@", "];
        }
        if(i == tvShowCast.crew.count){
            if([allDirectors length]!=0 )allDirectors = [allDirectors substringToIndex:[allDirectors length]-2];
            if([allWriters length]!=0 )allWriters = [allWriters substringToIndex:[allWriters length]-2];
        }
        i=i+1;
    }
}

-(NSString*)getSeasonNumberString{
    NSString* seasonsString = @"";
    
    NSInteger i;
    for(i=1; i<=[selectedTVShow.numberOfSeasons integerValue];i++){
        seasonsString = [seasonsString stringByAppendingString:[NSString stringWithFormat:@"%lu",i]];
        seasonsString = [seasonsString stringByAppendingString:@" "];
    }
    return seasonsString;
}
-(NSString*)getSeasonsYearsNumber{
    NSString* seasonYearsString = @"";
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy"];
    for(SingleSeason*  seasonItem in selectedTVShow.seasons){
        seasonYearsString = [seasonYearsString stringByAppendingString:[NSString stringWithFormat:@"%@",[df stringFromDate: seasonItem.airDate]]];
        seasonYearsString = [seasonYearsString stringByAppendingString:@" "];
    }
    return seasonYearsString;
}
-(NSString*)getGenresString{
    NSString* genreString;
    NSMutableArray* genresTemp = [[NSMutableArray alloc]init];
    for (Genre* g in selectedTVShow.genres){
        [genresTemp addObject:g.name];
    }
    genreString = [genresTemp componentsJoinedByString:@", "];
    return genreString;
}

-(NSString*)getTitleString{
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy"];
    return [[[[selectedTVShow.name uppercaseString] stringByAppendingString:@" ("] stringByAppendingString:[df stringFromDate:selectedTVShow.firstAirDate]] stringByAppendingString:@")"];
}
#pragma Fetching data
-(void)loadPopularTVShows{
    [tvShowService getTVShowDetailsFromAPIWithId:_tvshowId onSuccess:^(NSObject* object) {
        selectedTVShow = [(RKMappingResult*)object firstObject];
        [self.tableView reloadData];
    }onError:^(NSError* error){}];
}
-(void)loadTvShowTrailers{
    [tvShowService getTVShowTrailerFromAPIWithId:self.tvshowId onSuccess:^(NSObject* object){
        tvShowVideoCollection = [(RKMappingResult*)object firstObject];
        if(t)t = [tvShowVideoCollection.videoResults objectAtIndex:0];
        [self.tableView reloadData];
    } onError:^(NSError* error){}];
}
-(void)loadCast{
    [tvShowService getTVShowCastFromAPIWithId:self.tvshowId onSuccess:^(NSObject* object){
        tvShowCast = [(RKMappingResult*)object firstObject];
        [self.tableView reloadData];
    } onError:^(NSError* error){}];
}

#pragma Collection Views Handling

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([collectionView isKindOfClass:[ActorCollectionView class]]){
        return CGSizeMake(collectionView.frame.size.width/2.2 , collectionView.frame.size.height);
        
    }
    return CGSizeMake(collectionView.frame.size.width/2.2 , collectionView.frame.size.height/2.2);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1 ;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if([collectionView isKindOfClass:[ActorCollectionView class]]) return tvShowCast.cast.count;
    return 6;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell* cell = [[UICollectionViewCell alloc]init];
    if([collectionView isKindOfClass:[ActorCollectionView class]]){
        ActorCollectionViewCell* cellOneActor = (ActorCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:actorReuseIdentifier forIndexPath:indexPath];
        Actor* singleActor = [[Actor alloc]init];
        singleActor = (Actor*)[tvShowCast.cast objectAtIndex:indexPath.row];
        
        //Set up the single actor cell properties
        cellOneActor.actorRollLabel.text = singleActor.character;
        cellOneActor.actorNameLabel.text = singleActor.name;
        if(singleActor.profilePath){
            NSString* imageLink = [@"http://image.tmdb.org/t/p/w185/" stringByAppendingString: singleActor.profilePath];
            [cellOneActor.actorImageView sd_setImageWithURL:[NSURL URLWithString: imageLink] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];}
        return cellOneActor;
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 400.0f;
}


@end
