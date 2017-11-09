//
//  CastTableViewCell.m
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "ActorCollectionViewCell.h"
#import "ActorCollectionView.h"
#import "ActorCollectionViewCell.h"
#import "CastTableViewCell.h"
@interface CastTableViewCell()
@property (weak, nonatomic) IBOutlet ActorCollectionView *castCollectionView;

@end
@implementation CastTableViewCell
NSString* const castReuseIdentifier = @"castCell";
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setUpCastCollectionViewCellWithDelegate:(id)delegate withDataSource:(id)dataSource{
    self.castCollectionView.delegate = delegate;
    self.castCollectionView.dataSource = delegate;
    [self.castCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ActorCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:actorReuseIdentifier];
    [self.castCollectionView reloadData];}

@end
