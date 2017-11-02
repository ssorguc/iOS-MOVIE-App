//
//  CastTableViewCell.m
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "ActorCollectionViewCell.h"
#import "CastTableViewCell.h"

@implementation CastTableViewCell
NSString* const castReuseIdentifier = @"castCell";
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
