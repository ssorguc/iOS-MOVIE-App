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
}
@end

@implementation TVShowCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Registration of custom cell class
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MovieTvShowCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:movieTVShowReuseIdentifier];
    
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
    //Setting up the black gradient on coverImageView
    /*CAGradientLayer* bottomBox = [CAGradientLayer layer];
    bottomBox.frame = cell.coverImageView.bounds;
    bottomBox = [Gradient setUpGradient];
    bottomBox.frame = CGRectMake(0, 0, collectionView.frame.size.width/2.2 , collectionView.frame.size.height/2.2);
    [cell.coverImageView.layer addSublayer:bottomBox];*/
    
    tvShowSample = [[TVShow alloc]init];
    tvShowSample = (TVShow*)[tvShowArray objectAtIndex:indexPath.row];
    
    //Setting up the cover image of the cell
    NSString* imageLink = [@"http://image.tmdb.org/t/p/w185/" stringByAppendingString: tvShowSample.posterPath];
    [cell.coverImageView sd_setImageWithURL:[NSURL URLWithString: imageLink] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode: NSNumberFormatterRoundUp];
    cell.titleLabel.text = [tvShowSample.originalName uppercaseString];
    cell.rateLabel.text = [formatter stringFromNumber: tvShowSample.voteAverage];
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"dd.MM.yyyy"];
    NSString *result = [df stringFromDate:tvShowSample.firstAirDate];
    cell.dateLabel.text = result;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"tvShowDetailsSegue" sender:indexPath];
}

-(void)loadTVShows{
    tvShowArray = [[NSMutableArray alloc]init];
    TVShowService* tvShowService = [[TVShowService alloc]init];
    
    [tvShowService getTVShowFromAPIonSuccess:^(NSObject* object){
        TVShowCollection *collection = [(RKMappingResult*)object firstObject];
        [tvShowArray addObjectsFromArray:[collection results]];
        [self.collectionView reloadData];
    } onError:^(NSError* error){
        
    }];
   
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width/2.2 , collectionView.frame.size.height/2.2);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"tvShowDetailsSegue"]) {
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] lastObject];
        TVShowDetailTableViewController* tvshowTVC = [segue destinationViewController];
        tvshowTVC.tvshowId = [[tvShowArray objectAtIndex:indexPath.row] tvShowId];
    }
}
@end
