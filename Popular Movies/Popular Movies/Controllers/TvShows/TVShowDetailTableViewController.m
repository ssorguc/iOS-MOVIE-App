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
}
@end

@implementation TVShowDetailTableViewController

- (void)viewDidLoad {
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([MovieTrailerTableViewCell class]) bundle:nil] forCellReuseIdentifier:movieTrailerCellReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([ImageGalleryTableViewCell class]) bundle:nil] forCellReuseIdentifier:imageGalleryReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([MovieDescriptionTableViewCell class]) bundle:nil] forCellReuseIdentifier:descriptionReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([CastTableViewCell class]) bundle:nil] forCellReuseIdentifier:castReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SeasonsTableViewCell class]) bundle:nil] forCellReuseIdentifier:seasonsReuseIdentifier];
    tvShowService = [[TVShowService alloc]init];
    [self loadPopularTVShows];
    [self loadTvShowTrailers];
    [self loadCast];
    [super viewDidLoad];
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
    [cell setUpTrailerCellWithTitle:selectedTVShow.name releaseDateString:selectedTVShow.firstAirDate genresString:selectedTVShow.genres trailers:tvShowVideoCollection runtime:0 withIndexPath:indexPath];
    return cell;
}
- (MovieDescriptionTableViewCell*)setUpMovieDescriptionCell:(MovieDescriptionTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [cell setUpDescriptionCellWithCrew:tvShowCast.crew withRate:selectedTVShow.voteAverage withOverview:selectedTVShow.overview];
    return cell;
  }
- (SeasonsTableViewCell*)setUpSeasonsCell:(SeasonsTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [cell setUpSeasonsCellWithSeasons:selectedTVShow.seasons withNumberOfSeasons:selectedTVShow.numberOfSeasons];
    return cell;
}
-(CastTableViewCell*)setUpCastCollectionCell:(CastTableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath{
    [cell setUpCastCollectionViewCellWithDelegate:self withDataSource:self];
    return cell;
}

#pragma Fetching data
-(void)loadPopularTVShows{
    [tvShowService getTVShowDetailsFromAPIWithId:_tvshowId onSuccess:^(NSObject* object) {
        selectedTVShow = [(RKMappingResult*)object firstObject];
        [self.tableView reloadData];
    }onError:^(NSError* error){
        NSLog(@"There's been an error with requestiong data from API.");
    }];
}
-(void)loadTvShowTrailers{
    [tvShowService getTVShowTrailerFromAPIWithId:self.tvshowId onSuccess:^(NSObject* object){
        tvShowVideoCollection = [(RKMappingResult*)object firstObject];
        if(t)t = [tvShowVideoCollection.videoResults objectAtIndex:0];
        [self.tableView reloadData];
    } onError:^(NSError* error){
        NSLog(@"There's been an error with requestiong data from API.");
    }];
}
-(void)loadCast{
    [tvShowService getTVShowCastFromAPIWithId:self.tvshowId onSuccess:^(NSObject* object){
        tvShowCast = [(RKMappingResult*)object firstObject];
        [self.tableView reloadData];
    } onError:^(NSError* error){
        NSLog(@"There's been an error with requestiong data from API.");
    }];
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
        if(tvShowCast.cast) singleActor = (Actor*)[tvShowCast.cast objectAtIndex:indexPath.row];
        [cellOneActor setUpActorCellWithActor:singleActor];
        return cellOneActor;
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 400.0f;
}


@end
