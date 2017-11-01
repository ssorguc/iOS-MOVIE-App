//
//  Genre.h
//  Popular Movies
//
//  Created by Test on 26/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MappableEntity.h"
@interface Genre : MappableEntity
@property (nonatomic,strong) NSNumber* genreId;
@property (nonatomic,strong) NSString* name;
@end
