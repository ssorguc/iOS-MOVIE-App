//
//  NewsTableViewCell.h
//  Popular Movies
//
//  Created by Test on 11/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
//one cell in rss feed table view list
@interface NewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *linkLabel;
@property (weak, nonatomic) IBOutlet UIView *backgroundBox;
@end
