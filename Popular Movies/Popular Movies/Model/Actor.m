//
//  Actor.m
//  Popular Movies
//
//  Created by Test on 14/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "Actor.h"
//This class is a model for a single actor
@implementation Actor
- (NSDictionary*)registrationData {
    return @{
             @"cast_id": _castId,
             @"character": _character,
             @"credit_id": _creditId,
             @"gender": _gender,
             @"id": _actorId,
             @"name": _name,
             @"order": _order,
             @"profile_path": _profilePath
             };
}

+ (NSArray*)fieldsArrayForMapping {
    return @[ @"character", @"gender",@"name",@"order"];
}

+ (NSDictionary*)fieldsDictionaryForMapping {
    return @{
             @"cast_id": @"castId",
              @"credit_id": @"creditId",
              @"id": @"actorId",
              @"profile_path": @"profilePath"
             };
}
@end
