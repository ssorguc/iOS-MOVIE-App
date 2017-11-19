//
//  ReviewTableViewCell.h
//  Popular Movies
//
//  Created by Test on 26/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewsTableView.h"
#import <Foundation/Foundation.h>
@interface ReviewTableViewCell : UITableViewCell
extern NSString* const reviewReuseIdentifier;
-(void)setUpReviewsCellWithDelegate:(id)delegate withDataSource:(id)dataSource;
@end
