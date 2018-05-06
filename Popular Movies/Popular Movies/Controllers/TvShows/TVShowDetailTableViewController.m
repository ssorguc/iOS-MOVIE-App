//
//  TVShowDetailTableViewController.m
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "ImageGalleryViewController.h"
#import "ActorViewController.h"
#import "ActorCollectionView.h"
#import "SingleReviewTableViewCell.h"
#import "SeasonsViewController.h"
#import "ActorCollectionViewCell.h"
#import "TrailerViewController.h"
#import "CrewMember.h"
#import "ImageGalleryCollectionView.h"
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
#import "SingleImageCollectionViewCell.h"
#import "DirectorWriterTableViewCell.h"
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
    BOOL isExpanded;
}
@end

@implementation TVShowDetailTableViewController

- (void)viewDidLoad {
    
    //Defining navigatoin bar title
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero] ;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:17.0];
    label.text = @"TV Show";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([MovieTrailerTableViewCell class]) bundle:nil] forCellReuseIdentifier:movieTrailerCellReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([DirectorWriterTableViewCell class]) bundle:nil] forCellReuseIdentifier:directorWriterReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([ImageGalleryTableViewCell class]) bundle:nil] forCellReuseIdentifier:imageGalleryReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([MovieDescriptionTableViewCell class]) bundle:nil] forCellReuseIdentifier:descriptionReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([CastTableViewCell class]) bundle:nil] forCellReuseIdentifier:castReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SeasonsTableViewCell class]) bundle:nil] forCellReuseIdentifier:seasonsReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([ImageGalleryTableViewCell class]) bundle:nil] forCellReuseIdentifier:imageGalleryReuseIdentifier];

    
    tvShowService = [[TVShowService alloc]init];
    [self loadTVShowDetails];
    [self loadTvShowTrailers];
    [self loadCast];
    
    isExpanded = NO;

    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.backgroundColor = [UIColor blackColor];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
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
            MovieTrailerTableViewCell *cell0 = (MovieTrailerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:movieTrailerCellReuseIdentifier forIndexPath:indexPath];
            cell0.backgroundColor = [UIColor blackColor];
            cell0.delegate = self;
            return [self setUpTrailerCell:cell0 atIndexPath:indexPath];
        }
    
        else if (indexPath.section == 1){
            MovieDescriptionTableViewCell *cell1 = (MovieDescriptionTableViewCell*)[tableView dequeueReusableCellWithIdentifier:descriptionReuseIdentifier forIndexPath:indexPath];
            cell1.backgroundColor = [UIColor blackColor];
            return [self setUpMovieDescriptionCell:cell1 atIndexPath:indexPath];
        }
        else if (indexPath.section == 2){
            SeasonsTableViewCell *cell2 = (SeasonsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:seasonsReuseIdentifier forIndexPath:indexPath];
            cell2.backgroundColor = [UIColor blackColor];
            return [self setUpSeasonsCell:cell2 atIndexPath:indexPath];
        }
        else if (indexPath.section == 3){
            ImageGalleryTableViewCell *cell3 =(ImageGalleryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:imageGalleryReuseIdentifier forIndexPath:indexPath];
            cell3.delegate = self;
            return [self setUpImageGalleryCell:cell3 atIndexPath:indexPath];
        }
        else if (indexPath.section == 4){
            CastTableViewCell *cell4 = (CastTableViewCell*)[tableView dequeueReusableCellWithIdentifier:castReuseIdentifier forIndexPath:indexPath];
            return [self setUpCastCollectionCell:cell4 atIndexPath:indexPath];
        }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

#pragma Custom cell setup


- (MovieTrailerTableViewCell*)setUpTrailerCell:(MovieTrailerTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [cell setUpTrailerCellWithTitle:selectedTVShow.name releaseDateString:selectedTVShow.firstAirDate genresString:selectedTVShow.genres trailers:tvShowVideoCollection runtime:0 withIndexPath:indexPath withBackdropPath:selectedTVShow.backdropPath];
    return cell;
}
- (MovieDescriptionTableViewCell*)setUpMovieDescriptionCell:(MovieDescriptionTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [cell setUpDescriptionCellWithCrew:tvShowCast.crew withRate:selectedTVShow.voteAverage withOverview:selectedTVShow.overview];
    return cell;
  }
- (SeasonsTableViewCell*)setUpSeasonsCell:(SeasonsTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [cell setUpSeasonsCellWithSeasons:selectedTVShow.seasons withNumberOfSeasons:selectedTVShow.numberOfSeasons];
    cell.delegate = self;
    return cell;
}
-(CastTableViewCell*)setUpCastCollectionCell:(CastTableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath{
    [cell setUpCastCollectionViewCellWithDelegate:self withDataSource:self];
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}

-(ImageGalleryTableViewCell* )setUpImageGalleryCell:(ImageGalleryTableViewCell*)cell atIndexPath:(NSIndexPath* )indexPath{
    [cell setUpImagesGalleryCellWithImagesCollection:selectedTVShow.images withDelegate:self withDataSource:self];
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}


#pragma Fetching data from API methods

-(void)loadTVShowDetails{
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

#pragma mark - Collection Views Handling

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([collectionView isKindOfClass:[ActorCollectionView class]]){
        return CGSizeMake(collectionView.frame.size.width/4.2 , collectionView.frame.size.height);
    }
    if([collectionView isKindOfClass:[ImageGalleryCollectionView class]]){
        return CGSizeMake(collectionView.frame.size.width/3.6,collectionView.frame.size.height);
    }
    return CGSizeMake(collectionView.frame.size.width/2.2 , collectionView.frame.size.height/2.2);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1 ;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if([collectionView isKindOfClass:[ActorCollectionView class]]) return tvShowCast.cast.count;
    if([collectionView isKindOfClass:[ImageGalleryCollectionView class]]) return selectedTVShow.images.backdrops.count;
    return 6;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell* cell = [[UICollectionViewCell alloc]init];
    if([collectionView isKindOfClass:[ActorCollectionView class]]){
        ActorCollectionViewCell* cellOneActor = (ActorCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:actorReuseIdentifier forIndexPath:indexPath];
        Actor* singleActor = [[Actor alloc]init];
        if(tvShowCast.cast) singleActor = (Actor*)[tvShowCast.cast objectAtIndex:indexPath.row];
        [cellOneActor setUpActorCellWithActor:singleActor];
        cellOneActor.backgroundColor = [UIColor blackColor];
        return cellOneActor;
    }
    if([collectionView isKindOfClass:[ImageGalleryCollectionView class]]){
        SingleImageCollectionViewCell* cellImage = (SingleImageCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:singleImageReuseIdentifier forIndexPath:indexPath];
        if(selectedTVShow.images.backdrops){
            [cellImage setUpSingleImageCellWithSingleImage:[selectedTVShow.images.backdrops objectAtIndex:indexPath.row]];
        }
        cellImage.backgroundColor = [UIColor blackColor];
        return cellImage;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if([collectionView isKindOfClass:[ActorCollectionView class]]){
        [self performSegueWithIdentifier:@"actorSegue" sender:indexPath];
    }
}
#pragma mark  - MovieTrailerTableViewCellDelegate mothods

- (void)playVideo {
    [self performSegueWithIdentifier:@"trailerSegue" sender:self];
}

#pragma mark - ImageGalleryTableViewCellDelegate methods
-(void)seeDetailGallery{
    [self performSegueWithIdentifier:@"imageGallerySegue" sender:self];
}

#pragma mark - SeasonsTableViewCellDelegate methods
-(void)seeAllSeasonsDetial{
    [self performSegueWithIdentifier:@"seasonsSegue" sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"trailerSegue"]){
        TrailerViewController *trailerVC = [segue destinationViewController];
        [self setUpViewTitleLabelWithTitle:@"Trailer" withController:trailerVC];
        for(Trailer* trailerItem in tvShowVideoCollection.videoResults){
            if([trailerItem.type isEqualToString:@"Trailer"]){
                trailerVC.selectedMovieTrailer = trailerItem;
                break;
            }
        }
        trailerVC.movieDescription = selectedTVShow.overview;
    }
    if ([segue.identifier isEqualToString:@"actorSegue"]) {
        NSIndexPath* indexPath = (NSIndexPath*)sender;
        ActorViewController* actorDetailsController = [segue destinationViewController];
        [self setUpViewTitleLabelWithTitle:@"Actor" withController:actorDetailsController];
        actorDetailsController.actorId = [[tvShowCast.cast objectAtIndex:indexPath.row] actorId];
    }
    if([segue.identifier isEqualToString:@"imageGallerySegue"]){
        ImageGalleryViewController *imageGalleryViewController = [segue destinationViewController];
        [self setUpViewTitleLabelWithTitle:@"Image Gallery" withController:imageGalleryViewController];
        imageGalleryViewController.imagesCollection = selectedTVShow.images;
    }
    if([segue.identifier isEqualToString:@"seasonsSegue"]){
        SeasonsViewController *seasonsViewController = [segue destinationViewController];
        [self setUpViewTitleLabelWithTitle:@"Seasons" withController:seasonsViewController];
        seasonsViewController.numberOfSeasons = selectedTVShow.numberOfSeasons;
    }
}
-(void)setUpViewTitleLabelWithTitle:(NSString*)title withController:(UIViewController*)controller{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero] ;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:17.0];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    controller.navigationItem.titleView = label;
}
@end
