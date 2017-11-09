//
//  CrewMember.h
//  Popular Movies
//
//  Created by Test on 31/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MappableEntity.h"
@interface CrewMember : MappableEntity
@property (nonatomic,strong) NSString* department;
@property (nonatomic,strong) NSString* job;
@property (nonatomic,strong) NSString* name;
@end
