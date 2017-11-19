//
//  MoviesViewController.m
//  Popular Movies
//
//  Created by Test on 19/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "MoviesViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MovieService.h"
#import "MovieCollection.h"
#import "MovieTvShowCollectionViewCell.h"
#import "Movie.h"
#import "Genre.h"
#import "MovieDetailTableViewController.h"
#import <RestKit/RestKit.h>
@interface MoviesViewController ()
{
    NSMutableArray* moviesArray;
    MovieService* movieService;
    Movie* movieSample;
    NSInteger numberOfPages;
}
@property (weak, nonatomic) IBOutlet UICollectionView *moviesCollectionView;
@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.moviesCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MovieTvShowCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:movieTVShowReuseIdentifier];
    movieService = [[MovieService alloc]init];
    moviesArray = [[NSMutableArray alloc]init];
    numberOfPages=1;
    [self loadPopularMovies];
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
    [cell setUpMovieTvShowCollectionViewCellWithTitle:movieSample.title imageLink:movieSample.posterPath releaseDate:movieSample.releaseDate rating:movieSample.voteAverage];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width/2.2 , collectionView.frame.size.height/2.2);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"movieDetailSegue" sender:indexPath];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"movieDetailSegue"]) {
        NSIndexPath *indexPath = [[self.moviesCollectionView indexPathsForSelectedItems] lastObject];
        MovieDetailTableViewController* movieDetailTVC = [segue destinationViewController];
        movieDetailTVC.movieId = [[moviesArray objectAtIndex:indexPath.row] movieId];
    }
}
-(void)loadPopularMovies{
    [movieService gePopularMoviesFromAPIWithPage:numberOfPages onSuccess:^(NSObject* object){
        MovieCollection *collection = [(RKMappingResult*)object firstObject];
        [moviesArray addObjectsFromArray:[collection results]];
        numberOfPages=numberOfPages+1;
        [self.moviesCollectionView reloadData];
    } onError:^(NSError* error){}];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentYoffset = scrollView.contentOffset.y;
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentYoffset;
    if(distanceFromBottom < height)
    {
        [self loadPopularMovies];
    }
}
@end
