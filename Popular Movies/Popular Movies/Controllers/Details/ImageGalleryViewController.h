//
//  ImageGalleryViewController.h
//  Popular Movies
//
//  Created by Test on 29/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagesCollection.h"
#import "SingleImage.h"
@interface ImageGalleryViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) ImagesCollection *imagesCollection;
@end
