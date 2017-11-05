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
-(void)setUpDescriptionCellWithCrew:(NSArray*)crew withRate:(NSNumber*)rate withOverview:(NSString*)overview;
extern NSString* const descriptionReuseIdentifier;
@end
