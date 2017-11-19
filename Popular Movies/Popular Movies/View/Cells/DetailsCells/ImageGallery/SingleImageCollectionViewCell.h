//
//  SingleImageCollectionViewCell.h
//  Popular Movies
//
//  Created by Test on 19/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleImage.h"
@interface SingleImageCollectionViewCell : UICollectionViewCell
extern NSString* const singleImageReuseIdentifier;
-(void)setUpSingleImageCellWithSingleImage:(SingleImage*)singleImage;
@end
