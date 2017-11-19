//
//  CastTableViewCell.h
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ActorCollectionViewCell.h"
@interface CastTableViewCell : UITableViewCell
extern NSString* const castReuseIdentifier;
-(void)setUpCastCollectionViewCellWithDelegate:(id)delegate withDataSource:(id)dataSource;
@end
