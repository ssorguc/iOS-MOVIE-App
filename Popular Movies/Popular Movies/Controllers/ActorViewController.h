//
//  ActorViewController.h
//  Popular Movies
//
//  Created by Test on 08/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActorViewController : UIViewController <UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic,strong) NSNumber* actorId;
@end
