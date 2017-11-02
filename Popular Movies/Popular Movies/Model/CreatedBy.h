//
//  CreatedBy.h
//  Popular Movies
//
//  Created by Test on 29/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MappableEntity.h"
@interface CreatedBy : MappableEntity

@property (nonatomic,strong) NSNumber* creatorId;
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSNumber* gender;
@property (nonatomic,strong) NSString* profilePath;
@end
