//
//  ActorCollectionViewCell.h
//  Popular Movies
//
//  Created by Test on 31/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Actor.h"
@interface ActorCollectionViewCell : UICollectionViewCell
-(void)setUpActorCellWithActor:(Actor*)singleActor;
extern NSString* const actorReuseIdentifier;
@end
