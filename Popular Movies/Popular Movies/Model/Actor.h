//
//  Actor.h
//  Popular Movies
//
//  Created by Test on 14/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MappableEntity.h"
#import "MovieCredits.h"
@interface Actor : MappableEntity
@property (nonatomic,strong) NSNumber* castId;
@property (nonatomic,strong) NSString* character;
@property (nonatomic,strong) NSNumber* creditId;
@property (nonatomic,strong) NSNumber* gender;
@property (nonatomic,strong) NSString* actorId;
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSNumber* order;
@property (nonatomic,strong) NSString* profilePath;
@property (nonatomic,strong) NSString* backdropPath;
@property (nonatomic,strong) NSDate* birthday;
@property (nonatomic,strong) NSString* biography;
@property (nonatomic,strong) MovieCredits* movieCredits;
@property (nonatomic,strong) NSString* placeOfBirth;
@end
