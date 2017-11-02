//
//  TVShowDetailTableViewController.h
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVShowDetailTableViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic,strong) NSNumber* tvshowId;//Property used for transfering data between controllers
@end
