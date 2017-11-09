//
//  MoviesCollectionViewController.m
//  Popular Movies
//
//  Created by Test on 14/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "Movie.h"
#import "Genre.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MoviesCollectionViewController.h"
#import "MovieService.h"
#import "MovieTvShowCollectionViewCell.h"
#import "MovieCollection.h"
#import "Gradient.h"
#import <RestKit/RestKit.h>
#import "DirectorWriterTableViewCell.h"
#import "MovieDetailTableViewController.h"
@interface MoviesCollectionViewController ()
{
    NSMutableArray* moviesArray;
    MovieService* movieService;
    Movie* movieSample;
}
@end

@implementation MoviesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Registrate custom cell class
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MovieTvShowCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:movieTVShowReuseIdentifier];
    movieService = [[MovieService alloc]init];
    [self loadMovies];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return moviesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieTvShowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:movieTVShowReuseIdentifier forIndexPath:indexPath];

    movieSample = [[Movie alloc]init];
    movieSample = (Movie*)[moviesArray objectAtIndex:indexPath.row];
    
    //Setting up the cover image of the cell
    NSString* imageLink = [@"http://image.tmdb.org/t/p/w185/" stringByAppendingString: movieSample.posterPath];
    [cell.coverImageView sd_setImageWithURL:[NSURL URLWithString: imageLink] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    //Setting up the title of the movie
    cell.titleLabel.text = [movieSample.title uppercaseString];
    
    //Setting up the release date of the movie
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"d MMMM yyyy"];
    NSString *result = [df stringFromDate:movieSample.releaseDate];
    cell.dateLabel.text = result;
    
    //Setting up the vote average of the movie
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode: NSNumberFormatterRoundUp];
    cell.rateLabel.text = [formatter stringFromNumber:movieSample.voteAverage];
    return cell;
}

-(void)loadMovies{
    moviesArray = [[NSMutableArray alloc]init];
    [movieService getPopularMoviesFromAPIonSuccess:^(NSObject* object){
        MovieCollection *collection = [(RKMappingResult*)object firstObject];
        [moviesArray addObjectsFromArray:[collection results]];
        [self.collectionView reloadData];
    } onError:^(NSError* error){
        NSLog(@"There's been an error with requestiong data from API.");
    }];
    [movieService getTopRatedMoviesFromAPIonSuccess:^(NSObject* object){
        MovieCollection *collection = [(RKMappingResult*)object firstObject];
        [moviesArray addObjectsFromArray:[collection results]];
        [self.collectionView reloadData];
    } onError:^(NSError* error){
        NSLog(@"There's been an error with requestiong data from API.");
    }];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"movieDetailSegue" sender:indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width/2.2 , collectionView.frame.size.height/2.2);
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"movieDetailSegue"]) {
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] lastObject];
        MovieDetailTableViewController* movieDetailTVC = [segue destinationViewController];
        movieDetailTVC.movieId = [[moviesArray objectAtIndex:indexPath.row] movieId];
    }
}
@end
