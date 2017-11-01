//
//  TVShowDetailTableViewController.h
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVShowDetailTableViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSNumber* tvshowId;
@end
