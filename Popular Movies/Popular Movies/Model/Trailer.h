//
//  Trailer.h
//  Popular Movies
//
//  Created by Test on 28/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MappableEntity.h"

@interface Trailer : MappableEntity
@property (nonatomic,strong) NSNumber* trailerId;
@property (nonatomic,strong) NSString* key;
@property (nonatomic,strong) NSString* type;
@end
