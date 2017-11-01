//
//  SeasonsTableViewCell.h
//  Popular Movies
//
//  Created by Test on 26/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeasonsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *seasonsNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *seasonsYearsLabel;


extern NSString* const seasonsReuseIdentifier;
@end
