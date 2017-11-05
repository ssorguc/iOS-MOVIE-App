//
//  CastCollection.m
//  Popular Movies
//
//  Created by Test on 29/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "CrewMember.h"
#import "CastCollection.h"
#import "RelationshipObject.h"
#import "Actor.h"
@implementation CastCollection
- (NSDictionary*)registrationData {
    return @{
             @"id":_movieID
             };
}

+ (NSDictionary*)fieldsDictionaryForMapping {
    return @{
             @"id":@"movieID"
             };
}
+(NSArray*)keyPathes {
    return nil;
}
+ (NSArray*)pathPatterns {
    return @[@"/3/movie/:movieId/credits",
             @"/3/tv/:tvId/credits"
             ];
}
+(NSArray*)relationships {
    return @[[RelationshipObject relationshipWithKey:@"cast" andMappingClass:[Actor class]],
             [RelationshipObject relationshipWithKey:@"crew" andMappingClass:[CrewMember class]]];
}
@end
