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
#import "TrailerViewController.h"
#import "ActorViewController.h"
#import "MovieService.h"
#import "CastCollection.h"
#import "Actor.h"
#import "ImageGalleryCollectionView.h"
#import "SingleReview.h"
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
#import "ImageGalleryViewController.h"
#import "ReviewsTableView.h"
#import "SingleReviewTableViewCell.h"
#import "ActorCollectionView.h"
#import "DirectorWriterTableViewCell.h"
#import "CrewMember.h"
#import "SingleImageCollectionViewCell.h"
@interface MovieDetailTableViewController (){
    MovieService* movieService;
    Movie* selectedMovie;
    NSString* allDirectors;
    NSString* allWriters;
    BOOL isExpanded;
}
@end

@implementation MovieDetailTableViewController

- (void)viewDidLoad {
    
    //Defining navigatoin bar title
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero] ;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:17.0];
    label.text = @"Movies";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    
    //Registrating custom cells
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([MovieTrailerTableViewCell class]) bundle:nil] forCellReuseIdentifier:movieTrailerCellReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([ImageGalleryTableViewCell class]) bundle:nil] forCellReuseIdentifier:imageGalleryReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([MovieDescriptionTableViewCell class]) bundle:nil] forCellReuseIdentifier:descriptionReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([CastTableViewCell class]) bundle:nil] forCellReuseIdentifier:castReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ReviewTableViewCell class]) bundle:nil] forCellReuseIdentifier:reviewReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DirectorWriterTableViewCell class]) bundle:nil] forCellReuseIdentifier:directorWriterReuseIdentifier];
    
    //Getting movie details data
    movieService = [[MovieService alloc]init];
    [self loadMovieDetails];
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.backgroundColor = [UIColor blackColor];
    
    isExpanded = NO;
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numS = 6;
    if([tableView isKindOfClass:[ReviewsTableView class]])
        return 1;
    if(selectedMovie.reviews.results.count==0)
        return numS-1;
    
    return numS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([tableView isKindOfClass:[ReviewsTableView class]]){
        return selectedMovie.reviews.results.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [[UITableViewCell alloc]init];
    if([tableView isKindOfClass:[ReviewsTableView class]]){
        SingleReviewTableViewCell* cellR = (SingleReviewTableViewCell*)[tableView dequeueReusableCellWithIdentifier:singleReviewReuseIdentifier forIndexPath:indexPath];
        cellR.backgroundColor = [UIColor blackColor];
        return [self setUpSingleReviewCell:cellR atIndexPath:indexPath];
    }
    else{
        if(indexPath.section == 0){
            MovieTrailerTableViewCell* cell0 = (MovieTrailerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:movieTrailerCellReuseIdentifier forIndexPath:indexPath];
            cell0.backgroundColor = [UIColor blackColor];
            cell0.delegate = self;
            return [self setUpMovieTrailerCell:cell0 atIndexPath:indexPath];
         }
        else if(indexPath.section == 1){
            DirectorWriterTableViewCell* cell1 =(DirectorWriterTableViewCell*)[tableView dequeueReusableCellWithIdentifier:directorWriterReuseIdentifier forIndexPath:indexPath];
            cell1.backgroundColor = [UIColor blackColor];
            return [self setUpDirectorsWritersCells:cell1 atIndexPath:indexPath];
        }
        else if (indexPath.section == 2){
            MovieDescriptionTableViewCell* cell2 = (MovieDescriptionTableViewCell*)[tableView dequeueReusableCellWithIdentifier:descriptionReuseIdentifier forIndexPath:indexPath];
             cell2.backgroundColor = [UIColor blackColor];
             return [self setUpMovieDescriptionCell:cell2 atIndexPath:indexPath];
        }
        else if (indexPath.section == 3){
            ImageGalleryTableViewCell* cell3 = (ImageGalleryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:imageGalleryReuseIdentifier];
            cell3.backgroundColor = [UIColor blackColor];
            return [self setUpImageGalleryCell:cell3 atIndexPath:indexPath];
        }
        else if (indexPath.section == 4){
            CastTableViewCell* cell4 = (CastTableViewCell*)[tableView dequeueReusableCellWithIdentifier:castReuseIdentifier forIndexPath:indexPath];
            cell4.backgroundColor = [UIColor blackColor];
            return [self setUpCastCollectionCell:cell4 atIndexPath:indexPath];
        }
        else if (indexPath.section == 5){
            ReviewTableViewCell* cell5 = (ReviewTableViewCell*)[tableView dequeueReusableCellWithIdentifier:reviewReuseIdentifier forIndexPath:indexPath];
            cell5.backgroundColor = [UIColor blackColor];
            return [self setUpReviewsCell: cell5 atIndexPath:indexPath];
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

#pragma mark - Setting up custom cells

-(MovieTrailerTableViewCell* )setUpMovieTrailerCell:(MovieTrailerTableViewCell*)cell atIndexPath:(NSIndexPath* )indexPath{
    cell = [cell setUpTrailerCellWithTitle: selectedMovie.title releaseDateString: selectedMovie.releaseDate genresString: selectedMovie.genres trailers:selectedMovie.videos runtime: selectedMovie.runtime withIndexPath:indexPath withBackdropPath:selectedMovie.backdropPath];
    return cell;
}

-(MovieDescriptionTableViewCell* )setUpMovieDescriptionCell:(MovieDescriptionTableViewCell*)cell atIndexPath:(NSIndexPath* )indexPath{
    [cell setUpDescriptionCellWithCrew:selectedMovie.credits.crew withRate:selectedMovie.voteAverage withOverview:selectedMovie.overview];
    return cell;
}

-(ImageGalleryTableViewCell* )setUpImageGalleryCell:(ImageGalleryTableViewCell*)cell atIndexPath:(NSIndexPath* )indexPath{
    [cell setUpImagesGalleryCellWithImagesCollection:selectedMovie.images withDelegate:self withDataSource:self];
    cell.delegate = self;
    return cell;
}

-(DirectorWriterTableViewCell* )setUpDirectorsWritersCells:(DirectorWriterTableViewCell*)cell atIndexPath:(NSIndexPath* )indexPath{
    [cell setUpDirectorsWritersCellWithCrew:selectedMovie.credits.crew];
    return cell;
}

-(CastTableViewCell* )setUpCastCollectionCell:(CastTableViewCell*)cell atIndexPath:(NSIndexPath* )indexPath{
    [cell setUpCastCollectionViewCellWithDelegate:self withDataSource:self];
    return cell;
}

-(ReviewTableViewCell*)setUpReviewsCell:(ReviewTableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath{
    [cell setUpReviewsCellWithDelegate:self withDataSource:self];
    return cell;
}

-(SingleReviewTableViewCell* )setUpSingleReviewCell:(SingleReviewTableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath{
    SingleReview* singleReview = [[SingleReview alloc]init];
    if(selectedMovie.reviews.results) singleReview = (SingleReview*)[selectedMovie.reviews.results objectAtIndex:indexPath.row];
    cell.delegate = self;
    [cell setUpSingleReviewCellWithAuthor:singleReview.author withContent:singleReview.content isExtended:isExpanded withIndexPath:indexPath];
    return cell;
}

#pragma mark - Collection View data source

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
    if([collectionView isKindOfClass:[ActorCollectionView class]]) return selectedMovie.credits.cast.count;
    if([collectionView isKindOfClass:[ImageGalleryCollectionView class]]) return selectedMovie.images.backdrops.count;
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell* cell = [[UICollectionViewCell alloc]init];
    if([collectionView isKindOfClass:[ActorCollectionView class]]){
        ActorCollectionViewCell* cellOneActor = (ActorCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:actorReuseIdentifier forIndexPath:indexPath];
        Actor* singleActor = [[Actor alloc]init];
        if(selectedMovie.credits.cast) singleActor = (Actor*)[selectedMovie.credits.cast objectAtIndex:indexPath.row];
        [cellOneActor setUpActorCellWithActor:singleActor];
        return cellOneActor;
    }
    if([collectionView isKindOfClass:[ImageGalleryCollectionView class]]){
        SingleImageCollectionViewCell* cellImage = (SingleImageCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:singleImageReuseIdentifier forIndexPath:indexPath];
        if(selectedMovie.images.backdrops){
          [cellImage setUpSingleImageCellWithSingleImage:[selectedMovie.images.backdrops objectAtIndex:indexPath.row]];
        }
        return cellImage;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if([collectionView isKindOfClass:[ActorCollectionView class]]){
        [self performSegueWithIdentifier:@"actorSegue" sender:indexPath];
    }

}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"actorSegue"]) {
        NSIndexPath* indexPath = (NSIndexPath*)sender;
        ActorViewController* actorDetailsController = [segue destinationViewController];
        [self setUpViewTitleLabelWithTitle:@"Actor" withController:actorDetailsController];
        actorDetailsController.actorId = [[selectedMovie.credits.cast objectAtIndex:indexPath.row] actorId];
    }
    if([segue.identifier isEqualToString:@"trailerSegue"]){
        TrailerViewController *trailerVC = [segue destinationViewController];
        [self setUpViewTitleLabelWithTitle:@"Trailer" withController:trailerVC];
        for(Trailer* trailerItem in selectedMovie.videos.videoResults){
            if([trailerItem.type isEqualToString:@"Trailer"]){
                trailerVC.selectedMovieTrailer = trailerItem;
                break;
            }
        }
        trailerVC.movieDescription = selectedMovie.overview;
    }
    if([segue.identifier isEqualToString:@"imageGallerySegue"]){
        ImageGalleryViewController *imageGalleryViewController = [segue destinationViewController];
        [self setUpViewTitleLabelWithTitle:@"Image Gallery" withController:imageGalleryViewController];
        imageGalleryViewController.imagesCollection = selectedMovie.images;
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

#pragma mark -Fetching data from API

-(void)loadMovieDetails{
    [movieService getMovieDetailsFromAPIWithId:self.movieId onSuccess:^(NSObject* object){
        selectedMovie = [(RKMappingResult*)object firstObject];
        [self.tableView reloadData];
    } onError:^(NSError* error){
        NSLog(@"There's been an error with requestiong data from API.");
    }];
}

#pragma mark - MovieTrailerTableViewCell delegate methods

- (void)playVideo {
    [self performSegueWithIdentifier:@"trailerSegue" sender:self];
}

#pragma mark - SingleReviewTableViewCellDelegate delegate methods

-(void)readMoreClick:(UIButton *)sender{
    isExpanded = !isExpanded;
    [self.tableView reloadData];
        
}

#pragma mark - ImageGalleryTableViewCellDelegate methods
-(void)seeDetailGallery{
    [self performSegueWithIdentifier:@"imageGallerySegue" sender:self];
}

@end
