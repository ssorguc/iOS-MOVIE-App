//
//  Actor.h
//  Popular Movies
//
//  Created by Test on 14/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MappableEntity.h"

@interface Actor : MappableEntity
@property (nonatomic,strong) NSNumber* castId;
@property (nonatomic,strong) NSString* character;
@property (nonatomic,strong) NSNumber* creditId;
@property (nonatomic,strong) NSNumber* gender;
@property (nonatomic,strong) NSString* actorId;
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSNumber* order;
@property (nonatomic,strong) NSString* profilePath;
@end
