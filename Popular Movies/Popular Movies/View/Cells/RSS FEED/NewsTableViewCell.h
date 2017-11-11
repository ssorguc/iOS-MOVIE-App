//
//  NewsTableViewCell.h
//  Popular Movies
//
//  Created by Test on 11/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "News.h"
#import <UIKit/UIKit.h>
//one cell in rss feed table view list
@interface NewsTableViewCell : UITableViewCell
-(void)setUpNewsCellWithNews:(News*)newsSample;
@end
