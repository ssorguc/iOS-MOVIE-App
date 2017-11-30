//
//  CastTableViewCell.m
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "ActorCollectionView.h"
#import "ActorCollectionViewCell.h"
#import "ActorCollectionView.h"
#import "ActorCollectionViewCell.h"
#import "CastTableViewCell.h"
#import "ActorViewController.h"
#import "ActorViewController.h"
@interface CastTableViewCell()
@property (weak, nonatomic) IBOutlet ActorCollectionView *castCollectionView;

@end

NSString* const castReuseIdentifier = @"castCell";

@implementation CastTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.castCollectionView.userInteractionEnabled = YES;
    self.selectionStyle = UITableViewCellEditingStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Setting up cell's properties

-(void)setUpCastCollectionViewCellWithDelegate:(id)delegate withDataSource:(id)dataSource{
    self.castCollectionView.delegate = delegate;
    self.castCollectionView.dataSource = delegate;
    [self.castCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ActorCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:actorReuseIdentifier];
    [self.castCollectionView reloadData];
}

@end
