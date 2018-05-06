//
//  SeasonsTableViewCell.h
//  Popular Movies
//
//  Created by Test on 26/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleSeason.h"

@protocol SeasonsTableViewCellDelegate<NSObject>
-(void)seeAllSeasonsDetial;
@end

extern NSString* const seasonsReuseIdentifier;

@interface SeasonsTableViewCell : UITableViewCell
@property (nonatomic,strong) id<SeasonsTableViewCellDelegate> delegate;
-(void)setUpSeasonsCellWithSeasons:(NSArray*)seasons  withNumberOfSeasons:(NSNumber*)numberOfSeasons;
@end
