//
//  TVShowCollectionViewController.m
//  Popular Movies
//
//  Created by Test on 14/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "TVShowCollectionViewController.h"
#import "MovieTvShowCollectionViewCell.h"
@interface TVShowCollectionViewController ()
{
    NSMutableArray* tvShowArray;
}
@end

@implementation TVShowCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Registration of custom cell class
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MovieTvShowCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
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
     MovieTvShowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}

-(void)loadTVShows{
    tvShowArray = [[NSMutableArray alloc]init];
    //Code under will be replace with code that fetches data from API
    [tvShowArray addObject:@"one"];
    [tvShowArray addObject:@"two"];
    [tvShowArray addObject:@"three"];
    [tvShowArray addObject:@"four"];
    [tvShowArray addObject:@"four"];
    [tvShowArray addObject:@"four"];
}

@end
