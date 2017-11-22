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
}
@end

@implementation MovieDetailTableViewController

- (void)viewDidLoad {
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([MovieTrailerTableViewCell class]) bundle:nil] forCellReuseIdentifier:movieTrailerCellReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([ImageGalleryTableViewCell class]) bundle:nil] forCellReuseIdentifier:imageGalleryReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([MovieDescriptionTableViewCell class]) bundle:nil] forCellReuseIdentifier:descriptionReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([CastTableViewCell class]) bundle:nil] forCellReuseIdentifier:castReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ReviewTableViewCell class]) bundle:nil] forCellReuseIdentifier:reviewReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DirectorWriterTableViewCell class]) bundle:nil] forCellReuseIdentifier:directorWriterReuseIdentifier];
    movieService = [[MovieService alloc]init];
    [self loadMovieDetails];
    [super viewDidLoad];
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
        cellR.backgroundColor = self.tableView.backgroundColor;
        return [self setUpSingleReviewCell:cellR atIndexPath:indexPath];
    }
    else{
        if(indexPath.section == 0){
            MovieTrailerTableViewCell* cell0 = (MovieTrailerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:movieTrailerCellReuseIdentifier forIndexPath:indexPath];
            cell0.backgroundColor = self.tableView.backgroundColor;
            return [self setUpMovieTrailerCell:cell0 atIndexPath:indexPath];
         }
        else if(indexPath.section == 1){
            DirectorWriterTableViewCell* cell1 =(DirectorWriterTableViewCell*)[tableView dequeueReusableCellWithIdentifier:directorWriterReuseIdentifier forIndexPath:indexPath];
            cell1.backgroundColor = self.tableView.backgroundColor;
            return [self setUpDirectorsWritersCells:cell1 atIndexPath:indexPath];
        }
        else if (indexPath.section == 2){
            MovieDescriptionTableViewCell* cell2 = (MovieDescriptionTableViewCell*)[tableView dequeueReusableCellWithIdentifier:descriptionReuseIdentifier forIndexPath:indexPath];
             cell2.backgroundColor = self.tableView.backgroundColor;
             return [self setUpMovieDescriptionCell:cell2 atIndexPath:indexPath];
        }
        else if (indexPath.section == 3){
            ImageGalleryTableViewCell* cell3 = (ImageGalleryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:imageGalleryReuseIdentifier];
            cell3.backgroundColor = self.tableView.backgroundColor;
            return [self setUpImageGalleryCell:cell3 atIndexPath:indexPath];
        }
        else if (indexPath.section == 4){
            CastTableViewCell* cell4 = (CastTableViewCell*)[tableView dequeueReusableCellWithIdentifier:castReuseIdentifier forIndexPath:indexPath];
            cell4.backgroundColor = self.tableView.backgroundColor;
            return [self setUpCastCollectionCell:cell4 atIndexPath:indexPath];
        }
        else if (indexPath.section == 5){
            ReviewTableViewCell* cell5 = (ReviewTableViewCell*)[tableView dequeueReusableCellWithIdentifier:reviewReuseIdentifier forIndexPath:indexPath];
            cell5.backgroundColor = self.tableView.backgroundColor;
            return [self setUpReviewsCell: cell5 atIndexPath:indexPath];
        }
    }
    return cell;
}
//Need to fix this method to use UITableViewAutomaticDimension!!!
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([tableView isKindOfClass:[ReviewsTableView class]]){
        return 200.0f;
    }
    if(indexPath.section == 0) return 420.0f;
    else if(indexPath.section == 1){
        static DirectorWriterTableViewCell* cell = nil;
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            cell = [self.tableView dequeueReusableCellWithIdentifier:directorWriterReuseIdentifier];
        });
        
        cell = [self setUpDirectorsWritersCells:cell atIndexPath:indexPath];
        
        return [self calculateHeightForConfiguredSizingCell:cell];
    }
    else if(indexPath.section == 2){
        static MovieDescriptionTableViewCell* cell = nil;
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            cell = [self.tableView dequeueReusableCellWithIdentifier:descriptionReuseIdentifier];
        });
        
        cell = [self setUpMovieDescriptionCell:cell atIndexPath:indexPath];
        
        return [self calculateHeightForConfiguredSizingCell:cell];
    }
    else if(indexPath.section == 3) return 220.0f;
    else if(indexPath.section == 4) return 380.0f;
    else if(indexPath.section == 5){
        if(selectedMovie.reviews.results.count == 1) return 250.0f;
        else if(selectedMovie.reviews.results.count == 2)return 450.0f;
        else return 500.0f;
    }
    return 415.0f;
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell layoutIfNeeded];
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}

#pragma Setting up custom cells

-(MovieTrailerTableViewCell* )setUpMovieTrailerCell:(MovieTrailerTableViewCell*)cell atIndexPath:(NSIndexPath* )indexPath{
    [cell setUpTrailerCellWithTitle: selectedMovie.title releaseDateString: selectedMovie.releaseDate genresString: selectedMovie.genres trailers:selectedMovie.videos runtime: selectedMovie.runtime withIndexPath:indexPath];
    return cell;
}

-(MovieDescriptionTableViewCell* )setUpMovieDescriptionCell:(MovieDescriptionTableViewCell*)cell atIndexPath:(NSIndexPath* )indexPath{
    [cell setUpDescriptionCellWithCrew:selectedMovie.credits.crew withRate:selectedMovie.voteAverage withOverview:selectedMovie.overview];
    return cell;
}

-(ImageGalleryTableViewCell* )setUpImageGalleryCell:(ImageGalleryTableViewCell*)cell atIndexPath:(NSIndexPath* )indexPath{
    [cell setUpImagesGalleryCellWithImagesCollection:selectedMovie.images withDelegate:self withDataSource:self];
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
    [cell setUpSingleReviewCellWithAuthor:singleReview.author withContent:singleReview.content];
    return cell;
}

#pragma Collection Views Handling

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([collectionView isKindOfClass:[ActorCollectionView class]]){
        return CGSizeMake(collectionView.frame.size.width/2.2 , collectionView.frame.size.height);
    }
    if([collectionView isKindOfClass:[ImageGalleryCollectionView class]]){
        return CGSizeMake(220.0f , 150.0f);
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
    if([collectionView isKindOfClass:[ActorCollectionView class]])[self performSegueWithIdentifier:@"actorSegue" sender:indexPath];
}

#pragma Segue handling
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"actorSegue"]) {
        NSIndexPath* indexPath = (NSIndexPath*)sender;
        ActorViewController* actorDetailsController = [segue destinationViewController];
        actorDetailsController.actorId = [[selectedMovie.credits.cast objectAtIndex:indexPath.row] actorId];
    }
}

#pragma Fetching data

-(void)loadMovieDetails{
    [movieService getMovieDetailsFromAPIWithId:self.movieId onSuccess:^(NSObject* object){
        selectedMovie = [(RKMappingResult*)object firstObject];
        [self.tableView reloadData];
    } onError:^(NSError* error){
        NSLog(@"There's been an error with requestiong data from API.");
    }];
}
@end
