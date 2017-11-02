//
//  MovieTvShowCollectionViewCell.m
//  Popular Movies
//
//  Created by Test on 16/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "MovieTvShowCollectionViewCell.h"
#import "Gradient.h"

@interface MovieTvShowCollectionViewCell()
@property (weak, nonatomic) CAGradientLayer *bottomBox;
@end

@implementation MovieTvShowCollectionViewCell
NSString * const movieTVShowReuseIdentifier = @"MovieTVShowCell";

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    if (_bottomBox == nil) {
        _bottomBox = [Gradient setUpGradient];
        [self.coverImageView.layer addSublayer:_bottomBox];
    }
    _bottomBox.frame = self.coverImageView.bounds;
}

@end
