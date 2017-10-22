//
//  MoviesCollectionViewController.m
//  Popular Movies
//
//  Created by Test on 14/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "MoviesCollectionViewController.h"
#import "MovieTvShowCollectionViewCell.h"
@interface MoviesCollectionViewController ()
{
    NSMutableArray* moviesArray;
}
@end

@implementation MoviesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Registrate custom cell class
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MovieTvShowCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self loadMovies];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return moviesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieTvShowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}

-(void)loadMovies{
    moviesArray = [[NSMutableArray alloc]init];
    //Code under will be replace with code that fetches data from API
    [ moviesArray addObject:@"1"];
    [ moviesArray addObject:@"2"];
    [ moviesArray addObject:@"3"];
    [ moviesArray addObject:@"4"];
    [ moviesArray addObject:@"4"];
    [ moviesArray addObject:@"4"];
}
@end
