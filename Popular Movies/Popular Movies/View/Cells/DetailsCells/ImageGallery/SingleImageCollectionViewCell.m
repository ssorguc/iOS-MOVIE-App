//
//  SingleImageCollectionViewCell.m
//  Popular Movies
//
//  Created by Test on 19/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import <SDWebImage/UIImageView+WebCache.h>
#import "SingleImageCollectionViewCell.h"
@interface SingleImageCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *singleImageView;

@end


NSString* const singleImageReuseIdentifier = @"imageCell";

@implementation SingleImageCollectionViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
}


-(void)setUpSingleImageCellWithSingleImage:(SingleImage*)singleImage{
    if(singleImage.filePath){
        NSString* imageLink = [@"http://image.tmdb.org/t/p/w342/" stringByAppendingString: singleImage.filePath];
        [self.singleImageView sd_setImageWithURL:[NSURL URLWithString: imageLink] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    self.singleImageView.clipsToBounds = YES;
}
@end
