//
//  MovieDetailTableViewController.m
//  Popular Movies
//
//  Created by Test on 23/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import <SDWebImage/UIImageView+WebCache.h>
#import "Movie.h"
#import "Genre.h"
#import "MovieService.h"
#import "CastCollection.h"
#import "Actor.h"
#import "SingleReview.h"
#import "YTPlayerView.h"
#import "CollectionReview.h"
#import "MovieDetailTableViewController.h"
#import "MovieTrailerTableViewCell.h"
#import "ImageGalleryTableViewCell.h"
#import "CastTableViewCell.h"
#import "MovieDescriptionTableViewCell.h"
#import "ReviewTableViewCell.h"
#import <RestKit/RestKit.h>
#import "VideosCollection.h"
#import "Trailer.h"
#import "ActorCollectionViewCell.h"
#import "ReviewsTableView.h"
#import "SingleReviewTableViewCell.h"
#import "ActorCollectionView.h"
#import "CrewMember.h"
@interface MovieDetailTableViewController (){
    MovieService* movieService;
    Movie* selectedMovie;
    NSString* trailerLink;
    VideosCollection* videos;
    CastCollection* castCollection;
    NSArray* cast;
    CollectionReview* reviewsCollection;
    Trailer* t;
    NSString* allWriters;
    NSString* allDirectors;
}
@end

@implementation MovieDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([MovieTrailerTableViewCell class]) bundle:nil] forCellReuseIdentifier:movieTrailerCellReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([ImageGalleryTableViewCell class]) bundle:nil] forCellReuseIdentifier:imageGalleryReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([MovieDescriptionTableViewCell class]) bundle:nil] forCellReuseIdentifier:descriptionReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([CastTableViewCell class]) bundle:nil] forCellReuseIdentifier:castReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ReviewTableViewCell class]) bundle:nil] forCellReuseIdentifier:reviewReuseIdentifier];
    
    movieService = [[MovieService alloc]init];
    [self loadMovieDetails];
    [self loadMovieTrailerByMovieId];
    [self loadCastDetails];
    [self loadReviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([tableView isKindOfClass:[ReviewsTableView class]])
        return 1;
    if(reviewsCollection.results.count==0)
        return 3;
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([tableView isKindOfClass:[ReviewsTableView class]]){
        return reviewsCollection.results.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [[UITableViewCell alloc]init];
    if([tableView isKindOfClass:[ReviewsTableView class]]){
        return [self setUpSingleReviewCell:(SingleReviewTableViewCell*)[tableView dequeueReusableCellWithIdentifier:singleReviewReuseIdentifier forIndexPath:indexPath] atIndexPath:indexPath];
    }
    else{
        if(indexPath.section == 0){
             return [self setUpMovieTrailerCell:(MovieTrailerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:movieTrailerCellReuseIdentifier forIndexPath:indexPath] atIndexPath:indexPath];
         }
         else if (indexPath.section == 1){
             return [self setUpMovieDescriptionCell:(MovieDescriptionTableViewCell*)[tableView dequeueReusableCellWithIdentifier:descriptionReuseIdentifier forIndexPath:indexPath] atIndexPath:indexPath];
        }
        else if (indexPath.section == 2){
            return [self setUpCastCollectionCell:(CastTableViewCell*)[tableView dequeueReusableCellWithIdentifier:castReuseIdentifier forIndexPath:indexPath] atIndexPath:indexPath];
        }
        else if (indexPath.section == 3){
            return [self setUpReviewsCell: (ReviewTableViewCell*)[tableView dequeueReusableCellWithIdentifier:reviewReuseIdentifier forIndexPath:indexPath] atIndexPath:indexPath];
        }
    }
    return cell;
}

#pragma Setting up custom cells

-(MovieTrailerTableViewCell* )setUpMovieTrailerCell:(MovieTrailerTableViewCell*)cell atIndexPath:(NSIndexPath* )indexPath{
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    //Release date label
    [df setDateFormat:@"d MMMM yyyy"];
    cell.releaseDateLabel.text = [df stringFromDate:selectedMovie.releaseDate];
    //Movie title label
    [df setDateFormat:@"yyyy"];
    cell.titleLabel.text = [[[[selectedMovie.title uppercaseString] stringByAppendingString:@" ("] stringByAppendingString:[df stringFromDate:selectedMovie.releaseDate]] stringByAppendingString:@")"];
    //Genres label
    NSMutableArray* genresTemp = [[NSMutableArray alloc]init];
    for (Genre* g in selectedMovie.genres){
        [genresTemp addObject:g.name];
    }
    cell.genreLabel.text = [genresTemp componentsJoinedByString:@", "];
    //Trailer video
    if(videos.videoResults.count!=0){
        t = [videos.videoResults objectAtIndex:0];
        NSDictionary *playerVars = @{@"playsinline" : @1,};
        [cell.movieTrailerPlayer loadWithVideoId:t.key playerVars:playerVars];
    }
    NSInteger value = [selectedMovie.runtime integerValue]/60;
    NSInteger value2 = [selectedMovie.runtime integerValue]- value*60;
    cell.durationLabel.text = [[[[NSString stringWithFormat:@"%lu",value]stringByAppendingString:@" h "]stringByAppendingString:[NSString stringWithFormat:@"%lu",value2]]stringByAppendingString:@" min"];
    return cell;
}
-(MovieDescriptionTableViewCell* )setUpMovieDescriptionCell:(MovieDescriptionTableViewCell*)cell atIndexPath:(NSIndexPath* )indexPath{
    cell.descriptionLabel.text = selectedMovie.overview;
    cell.directorLabel.text = trailerLink;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode: NSNumberFormatterRoundUp];
    cell.rateLabel.text = [formatter stringFromNumber:selectedMovie.voteAverage];
    [self getWritersDirectorsStringForLabel];
    cell.writerLabel.text = allWriters;
    cell.directorLabel.text = allDirectors;
    return cell;
}
-(CastTableViewCell* )setUpCastCollectionCell:(CastTableViewCell*)cell atIndexPath:(NSIndexPath* )indexPath{
    cell.castCollectionView.dataSource = self;
    cell.castCollectionView.delegate = self;
    [cell.castCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ActorCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:actorReuseIdentifier];
    [cell.castCollectionView reloadData];
    
    return cell;
}
-(ReviewTableViewCell*)setUpReviewsCell:(ReviewTableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath{
    cell.reviewsTableView.delegate = self;
    cell.reviewsTableView.dataSource = self;
    [cell.reviewsTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SingleReviewTableViewCell class]) bundle:nil] forCellReuseIdentifier:singleReviewReuseIdentifier];
    
    [cell.reviewsTableView reloadData];
    return cell;
}
-(SingleReviewTableViewCell* )setUpSingleReviewCell:(SingleReviewTableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath{
    SingleReview* singleReview = [[SingleReview alloc]init];
    if(reviewsCollection.results) singleReview = (SingleReview*)[reviewsCollection.results objectAtIndex:indexPath.row];
    cell.nameLabel.text = singleReview.author;
    cell.reviewContentLabel.text = singleReview.content;
    return cell;
}
-(void)getWritersDirectorsStringForLabel{
    allWriters = @"";
    allDirectors = @"";
    NSInteger i = 1;
    for(CrewMember* crewTemp in castCollection.crew){
        if([crewTemp.job isEqualToString:@"Director"]){
            allDirectors = [allDirectors stringByAppendingString:crewTemp.name];
            allDirectors = [allDirectors stringByAppendingString:@", "];
            
        }
        if([crewTemp.job isEqualToString:@"Writer"]){
            allWriters = [allWriters stringByAppendingString:crewTemp.name];
            allWriters = [allWriters stringByAppendingString:@", "];
        }
        if(i == castCollection.crew.count){
            if([allDirectors length]!=0 )allDirectors = [allDirectors substringToIndex:[allDirectors length]-2];
            if([allWriters length]!=0 )allWriters = [allWriters substringToIndex:[allWriters length]-2];
        }
        i=i+1;
    }
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
    if([collectionView isKindOfClass:[ActorCollectionView class]]) return castCollection.cast.count;
    return 6;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell* cell = [[UICollectionViewCell alloc]init];
    if([collectionView isKindOfClass:[ActorCollectionView class]]){
        ActorCollectionViewCell* cellOneActor = (ActorCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:actorReuseIdentifier forIndexPath:indexPath];
        Actor* singleActor = [[Actor alloc]init];
        if(castCollection.cast) singleActor = (Actor*)[castCollection.cast objectAtIndex:indexPath.row];
        
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

    if(indexPath.section == 1){
        static MovieDescriptionTableViewCell* cell = nil;
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            cell = [self.tableView dequeueReusableCellWithIdentifier:descriptionReuseIdentifier];
        });
        
        cell = [self setUpMovieDescriptionCell:cell atIndexPath:indexPath];
        
        return [self calculateHeightForConfiguredSizingCell:cell];
    }
    else if(indexPath.section == 3){
        if(reviewsCollection.results.count == 1) return 250.0f;
        else if(reviewsCollection.results.count == 2)return 450.0f;
        else return 500.0f;
    }
    if([tableView isKindOfClass:[ReviewsTableView class]]){
        return 200.0f;
    }
    return 400.0f;
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell layoutIfNeeded];
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}

#pragma Fetching data
-(void)loadMovieTrailerByMovieId{
    [movieService getMovieTrailerFromAPIWithId:self.movieId onSuccess:^(NSObject* object){
        videos = [(RKMappingResult*)object firstObject];
        [self.tableView reloadData];
    } onError:^(NSError* error){
        
    }
     ];
}

-(void)loadMovieDetails{
    [movieService getMovieDetailsFromAPIWithId:self.movieId onSuccess:^(NSObject* object){
        selectedMovie = [(RKMappingResult*)object firstObject];
        [self.tableView reloadData];
    } onError:^(NSError* error){
        NSLog(@"greska");
    }];
}
-(void)loadCastDetails{
    [movieService getCastInformation:_movieId onSuccess:^(NSObject* object){
        castCollection = [(RKMappingResult*)object firstObject];
        [self.tableView reloadData];
    } onError:^(NSError* error){}];
}
-(void)loadReviews{
    [movieService getMovieReviewsFromAPIWithId:_movieId onSuccess:^(NSObject* object){
        reviewsCollection = [(RKMappingResult*)object firstObject];
        [self.tableView reloadData];
    } onError:^(NSError* error){}];
}



@end
