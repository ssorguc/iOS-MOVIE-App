//
//  ActorDetailsTableViewCell.h
//  Popular Movies
//
//  Created by Test on 20/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActorDetailsTableViewCell : UITableViewCell
extern NSString* const actorsDetailsReuseIdentifier;
-(ActorDetailsTableViewCell*)setUpActorsDetailsCellWithActorsName:(NSString*)name withProfilePath:(NSString*)profilePath withBirthday:(NSDate*)birthday withBirthPlace:(NSString*)place withBiography:(NSString*)biography;
@end
