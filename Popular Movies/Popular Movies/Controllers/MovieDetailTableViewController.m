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
    if([tableView isKindOfClass:[ReviewsTableView class]]) return 1;
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
        SingleReviewTableViewCell *reviewCell = (SingleReviewTableViewCell*)[tableView dequeueReusableCellWithIdentifier:singleReviewReuseIdentifier forIndexPath:indexPath];
        SingleReview* singleReview = [[SingleReview alloc]init];
        if(reviewsCollection.results) singleReview = (SingleReview*)[reviewsCollection.results objectAtIndex:indexPath.row];
        reviewCell.nameLabel.text = singleReview.author;
        reviewCell.reviewContentLabel.text = singleReview.content;
        return reviewCell;
    }
    else{
        if(indexPath.section == 0){
            MovieTrailerTableViewCell* cell1 = (MovieTrailerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:movieTrailerCellReuseIdentifier forIndexPath:indexPath];
            NSDateFormatter* df = [[NSDateFormatter alloc]init];
            
            //Release date
            [df setDateFormat:@"d MMMM yyyy"];
            cell1.releaseDateLabel.text = [df stringFromDate:selectedMovie.releaseDate];
            
            //Movie title
            [df setDateFormat:@"yyyy"];
            cell1.titleLabel.text = [[[[selectedMovie.title uppercaseString] stringByAppendingString:@" ("] stringByAppendingString:[df stringFromDate:selectedMovie.releaseDate]] stringByAppendingString:@")"];
            
            //Genres
            NSMutableArray* genresTemp = [[NSMutableArray alloc]init];
            for (Genre* g in selectedMovie.genres){
                [genresTemp addObject:g.name];
            }
            cell1.genreLabel.text = [genresTemp componentsJoinedByString:@", "];

            //Trailer video
            if(videos.videoResults.count!=0){
            t = [videos.videoResults objectAtIndex:0];
            NSDictionary *playerVars = @{@"playsinline" : @1,};
            [cell1.movieTrailerPlayer loadWithVideoId:t.key playerVars:playerVars];
            }
            NSInteger value = [selectedMovie.runtime integerValue]/60;
            NSInteger value2 = [selectedMovie.runtime integerValue]- value*60;
            cell1.durationLabel.text = [[[[NSString stringWithFormat:@"%lu",value]stringByAppendingString:@" h "]stringByAppendingString:[NSString stringWithFormat:@"%lu",value2]]stringByAppendingString:@" min"];
            return cell1;
         }
         else if (indexPath.section == 1){
            MovieDescriptionTableViewCell* cell2 = (MovieDescriptionTableViewCell*)[tableView dequeueReusableCellWithIdentifier:descriptionReuseIdentifier forIndexPath:indexPath];
             cell2.descriptionLabel.text = selectedMovie.overview;
             cell2.directorLabel.text = trailerLink;
             NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
             [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
             [formatter setMaximumFractionDigits:2];
             [formatter setRoundingMode: NSNumberFormatterRoundUp];
             cell2.rateLabel.text = [formatter stringFromNumber:selectedMovie.voteAverage];
             
             NSString* allWriters = @"";
             NSString* allDirectors = @"";
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
             cell2.writerLabel.text = allWriters;
             cell2.directorLabel.text = allDirectors;
             
            return cell2;
        }
        else if (indexPath.section == 2){
            CastTableViewCell* cell4 = (CastTableViewCell*)[tableView dequeueReusableCellWithIdentifier:castReuseIdentifier forIndexPath:indexPath];
            cell4.castCollectionView.dataSource = self;
            cell4.castCollectionView.delegate = self;
            [cell4.castCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ActorCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:actorReuseIdentifier];
            
            [cell4.castCollectionView reloadData];
            return cell4;
        }
        else if (indexPath.section == 3 ){
            if(reviewsCollection.totalResults == 0){
                //If there is no reviews it would implement different cell,for example that would say no reviews
            }
            else{
                ReviewTableViewCell* cell5 = (ReviewTableViewCell*)[tableView dequeueReusableCellWithIdentifier:reviewReuseIdentifier forIndexPath:indexPath];
                cell5.reviewsTableView.delegate = self;
                cell5.reviewsTableView.dataSource = self;
                [cell5.reviewsTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SingleReviewTableViewCell class]) bundle:nil] forCellReuseIdentifier:singleReviewReuseIdentifier];
                
                [cell5.reviewsTableView reloadData];
                return cell5;
            }
        }
    }
    return cell;
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
    return 400.0f;
}

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
