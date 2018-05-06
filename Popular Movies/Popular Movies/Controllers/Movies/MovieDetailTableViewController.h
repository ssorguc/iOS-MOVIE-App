//
//  MovieDetailTableViewController.h
//  Popular Movies
//
//  Created by Test on 23/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieTrailerTableViewCell.h"
#import "SingleReviewTableViewCell.h"
#import "ImageGalleryTableViewCell.h"
@interface MovieDetailTableViewController : UITableViewController <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource, MovieTrailerTableViewCellDelegate, SingleReviewTableViewCellDelegate, ImageGalleryTableViewCellDelegate>
@property (nonatomic,strong) NSNumber* movieId; //Property used for transfering data between controllers
@end
