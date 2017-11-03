//
//  MovieDescriptionTableViewCell.h
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface MovieDescriptionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *starsLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorLabel;
@property (weak, nonatomic) IBOutlet UILabel *writerLabel;

@property (weak, nonatomic) IBOutlet UILabel *directorStaticLabel;
@property (weak, nonatomic) IBOutlet UILabel *writerStaticLabel;
extern NSString* const descriptionReuseIdentifier;
@end
