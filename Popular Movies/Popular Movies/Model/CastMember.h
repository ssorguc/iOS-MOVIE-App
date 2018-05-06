//
//  CastMember.h
//  Popular Movies
//
//  Created by Test on 22/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MappableEntity.h"
@interface CastMember : MappableEntity
@property (nonatomic,strong) NSString* posterPath;
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSString* character;



@end
