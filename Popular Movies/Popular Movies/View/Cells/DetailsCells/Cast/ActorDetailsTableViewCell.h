//
//  ActorDetailsTableViewCell.h
//  Popular Movies
//
//  Created by Test on 20/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ActorDetailsTableViewCellDelegate <NSObject>

- (void)readMoreClick:(UIButton*)sender;
@end

extern NSString* const actorsDetailsReuseIdentifier;

@interface ActorDetailsTableViewCell : UITableViewCell
@property (nonatomic, strong) id<ActorDetailsTableViewCellDelegate> delegate;


-(ActorDetailsTableViewCell*)setUpActorsDetailsCellWithActorsName:(NSString*)name withProfilePath:(NSString*)profilePath withBirthday:(NSDate*)birthday withBirthPlace:(NSString*)place withBiography:(NSString*)biography isExpended:(BOOL)isExpended;

@end
