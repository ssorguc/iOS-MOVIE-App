//
//  SingleReviewTableViewCell.h
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleReviewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *reviewContentLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
extern NSString* const singleReviewReuseIdentifier;
@end
