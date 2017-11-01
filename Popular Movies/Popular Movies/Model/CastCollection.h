//
//  CastCollection.h
//  Popular Movies
//
//  Created by Test on 29/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MappableEntity.h"
@interface CastCollection : MappableEntity
@property (nonatomic,strong) NSNumber* movieID;
@property (nonatomic,strong) NSArray* cast;
@property (nonatomic,strong)NSArray* crew;
@end
