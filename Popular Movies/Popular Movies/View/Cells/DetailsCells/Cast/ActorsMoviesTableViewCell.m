//
//  ActorsMoviesTableViewCell.m
//  Popular Movies
//
//  Created by Test on 21/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "ActorCollectionViewCell.h"
#import "ActorsMoviesTableViewCell.h"
@interface ActorsMoviesTableViewCell()
@property (weak, nonatomic) IBOutlet UICollectionView *actorsMoviesCollectionView;

@end
@implementation ActorsMoviesTableViewCell
NSString* const ActorsMoviesReusableIdentifier = @"actorsMovieCell";
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(ActorsMoviesTableViewCell*)setUpActorsMoviesCollectionViewCellWithDelegate:(id)delegate withDataSource:(id)dataSource{
    self.actorsMoviesCollectionView.delegate = delegate;
    self.actorsMoviesCollectionView.dataSource = delegate;
    [self.actorsMoviesCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ActorCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:actorReuseIdentifier];
    [self.actorsMoviesCollectionView reloadData];
    return self;
}
@end
