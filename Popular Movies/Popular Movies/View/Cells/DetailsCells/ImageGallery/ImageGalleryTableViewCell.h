//
//  ImageGalleryTableViewCell.h
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagesCollection.h"
@interface ImageGalleryTableViewCell : UITableViewCell
extern NSString* const imageGalleryReuseIdentifier;
-(void)setUpImagesGalleryCellWithImagesCollection:(ImagesCollection*)imagesCollection withDelegate:(id)delegate withDataSource:(id)dataSource;
@end
