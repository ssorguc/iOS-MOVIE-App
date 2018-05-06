//
//  TVShowDetailTableViewController.h
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageGalleryTableViewCell.h"
#import "SeasonsTableViewCell.h"
#import "MovieTrailerTableViewCell.h"
@interface TVShowDetailTableViewController : UITableViewController <UICollectionViewDelegateFlowLayout, UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, MovieTrailerTableViewCellDelegate, ImageGalleryTableViewCellDelegate,SeasonsTableViewCellDelegate>
@property (nonatomic,strong) NSNumber* tvshowId;//Property used for transfering data between controllers
@end
