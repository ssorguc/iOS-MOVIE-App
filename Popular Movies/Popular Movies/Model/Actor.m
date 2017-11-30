//
//  Actor.m
//  Popular Movies
//
//  Created by Test on 14/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "RelationshipObject.h"
#import "Actor.h"
#import "Movie.h"
#import "MovieCredits.h"
#import "CastMember.h"
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
             @"profile_path": _profilePath,
             @"backdrop_path": _backdropPath,
             @"biography":_biography,
             @"birthday":_birthday,
             @"place_of_birth":_placeOfBirth
             };
}

+ (NSArray*)fieldsArrayForMapping {
    return @[ @"character", @"gender",@"name",@"order",@"biography",@"birthday"];
}
+(NSArray*)keyPathes {
    return nil;
}
+ (NSArray*)pathPatterns {
    return @[@"/3/person/:actorId"
             ];
}
+ (NSDictionary*)fieldsDictionaryForMapping {
    return @{
             @"cast_id": @"castId",
              @"credit_id": @"creditId",
              @"id": @"actorId",
              @"profile_path": @"profilePath",
             @"backdrop_path": @"backdropPath",
             @"place_of_birth":@"placeOfBirth"
             };
}

+(NSArray*)relationships {
    return @[[RelationshipObject relationshipWithSource:@"movie_credits" destination:@"movieCredits"  andMappingClass:[MovieCredits class]]
             ];
}
@end
