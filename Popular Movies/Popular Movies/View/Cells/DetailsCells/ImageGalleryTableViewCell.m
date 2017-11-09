//
//  ImageGalleryTableViewCell.m
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "ImageGalleryTableViewCell.h"

@implementation ImageGalleryTableViewCell
NSString* const imageGalleryReuseIdentifier = @"imageGalleryCell";
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
