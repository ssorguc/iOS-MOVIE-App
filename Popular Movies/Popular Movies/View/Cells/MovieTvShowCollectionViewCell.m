//
//  MovieTvShowCollectionViewCell.m
//  Popular Movies
//
//  Created by Test on 16/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "MovieTvShowCollectionViewCell.h"

@implementation MovieTvShowCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpGradient];
    // Initialization code
    
}
+(CAGradientLayer*)blackGradient{
    UIColor* one = [UIColor clearColor];
    UIColor* two = [UIColor blackColor];
    NSArray* colors = [NSArray arrayWithObjects:(id)one.CGColor,two.CGColor, nil];
    NSNumber* stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber* stopTwo = [NSNumber numberWithFloat:0.7];
    NSArray* locations = [NSArray arrayWithObjects:stopOne,stopTwo, nil];
    CAGradientLayer* bottomBox = [CAGradientLayer layer];
    bottomBox.colors = colors;
    bottomBox.locations = locations;
    return bottomBox;
}
-(void)setUpGradient{
    CAGradientLayer* gl1 = [MovieTvShowCollectionViewCell blackGradient];
    gl1.frame = self.coverImageView.bounds;
    self.coverImageView.layer.mask = gl1;
    [_coverImageView.layer insertSublayer:gl1 atIndex:0];
}
@end
