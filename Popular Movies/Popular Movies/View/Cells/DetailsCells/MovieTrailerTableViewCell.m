//
//  MovieTrailerTableViewCell.m
//  Popular Movies
//
//  Created by Test on 24/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "Gradient.h"
#import "MovieTrailerTableViewCell.h"
@interface MovieTrailerTableViewCell()
@property (weak, nonatomic) CAGradientLayer *bottomBox;
@end

@implementation MovieTrailerTableViewCell
NSString * const movieTrailerCellReuseIdentifier = @"movieTrailerCell";
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
