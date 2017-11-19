//
//  TVShowCollectionViewController.m
//  Popular Movies
//
//  Created by Test on 14/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import <SDWebImage/UIImageView+WebCache.h>
#import "Gradient.h"
#import <QuartzCore/QuartzCore.h>
#import "TVShowCollectionViewController.h"
#import "TVShowService.h"
#import "TVShowCollection.h"
#import "TVShow.h"
#import <RestKit/RestKit.h>
#import "TVShowDetailTableViewController.h"
#import "MovieTvShowCollectionViewCell.h"
@interface TVShowCollectionViewController ()
{
    NSMutableArray* tvShowArray;
    TVShow* tvShowSample;
    TVShowService* tvShowService;
    NSInteger numberOfPages;
}
@end

@implementation TVShowCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Registration of custom cell class
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MovieTvShowCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:movieTVShowReuseIdentifier];
    tvShowService = [[TVShowService alloc]init];
    tvShowArray = [[NSMutableArray alloc]init];
    numberOfPages = 1;
    [self loadTVShows];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return tvShowArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
     MovieTvShowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:movieTVShowReuseIdentifier forIndexPath:indexPath];
    tvShowSample = (TVShow*)[tvShowArray objectAtIndex:indexPath.row];
    [cell setUpMovieTvShowCollectionViewCellWithTitle:tvShowSample.name imageLink:tvShowSample.posterPath releaseDate:tvShowSample.firstAirDate rating:tvShowSample.voteAverage];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"tvShowDetailsSegue" sender:indexPath];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"tvShowDetailsSegue"]) {
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] lastObject];
        TVShowDetailTableViewController* tvshowTVC = [segue destinationViewController];
        tvshowTVC.tvshowId = [[tvShowArray objectAtIndex:indexPath.row] tvShowId];
    }
}
-(void)loadTVShows{
    [tvShowService getPopularTVShowFromAPIWithPageNumber:numberOfPages onSuccess:^(NSObject* object){
        TVShowCollection *collection = [(RKMappingResult*)object firstObject];
        [tvShowArray addObjectsFromArray:[collection results]];
        numberOfPages=numberOfPages+1;
        [self.collectionView reloadData];
    } onError:^(NSError* error){
        
    }];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width/2.2 , collectionView.frame.size.height/2.2);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentYoffset = scrollView.contentOffset.y;
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentYoffset;
    if(distanceFromBottom < height)
    {
        [self loadTVShows];
    }
}
@end
