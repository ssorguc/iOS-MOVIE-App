//
//  ActorCollectionViewCell.h
//  Popular Movies
//
//  Created by Test on 31/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActorCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *actorNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *actorImageView;
@property (weak, nonatomic) IBOutlet UILabel *actorRollLabel;
extern NSString* const actorReuseIdentifier;
@end
