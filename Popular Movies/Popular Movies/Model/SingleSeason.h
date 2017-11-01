//
//  SingleSeason.h
//  Popular Movies
//
//  Created by Test on 29/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MappableEntity.h"
@interface SingleSeason : MappableEntity
@property (nonatomic,strong) NSDate* airDate;
@property (nonatomic,strong) NSNumber* episodeCount;
@property (nonatomic,strong) NSNumber* showId;
@property (nonatomic,strong) NSString* posterPath;
@property (nonatomic,strong) NSNumber* seasonNumber;
@end
