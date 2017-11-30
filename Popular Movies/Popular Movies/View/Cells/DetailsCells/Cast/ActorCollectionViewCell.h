//
//  ActorCollectionViewCell.h
//  Popular Movies
//
//  Created by Test on 31/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Actor.h"

extern NSString* const actorReuseIdentifier;

@interface ActorCollectionViewCell : UICollectionViewCell

-(void)setUpActorCellWithActor:(Actor*)singleActor;
-(ActorCollectionViewCell*)setUpActorCellWithPosterPath:(NSString *)posterPath withFirstTitle:(NSString*)firstTitle withSecondTitle:(NSString*)secondTitle;
@end
