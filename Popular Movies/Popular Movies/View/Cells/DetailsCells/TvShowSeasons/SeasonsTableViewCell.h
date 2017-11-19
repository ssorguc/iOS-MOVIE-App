//
//  SeasonsTableViewCell.h
//  Popular Movies
//
//  Created by Test on 26/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleSeason.h"
@interface SeasonsTableViewCell : UITableViewCell
extern NSString* const seasonsReuseIdentifier;
-(void)setUpSeasonsCellWithSeasons:(NSArray*)seasons  withNumberOfSeasons:(NSNumber*)numberOfSeasons;
@end
