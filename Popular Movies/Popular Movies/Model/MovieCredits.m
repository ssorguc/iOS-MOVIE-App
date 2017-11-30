//
//  MovieCredits.m
//  Popular Movies
//
//  Created by Test on 22/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "CastMember.h"
#import "MovieCredits.h"
#import "RelationshipObject.h"
@implementation MovieCredits
+(NSArray*)keyPathes {
    return nil;
}

+(NSArray*)relationships {
    return @[[RelationshipObject relationshipWithKey:@"cast" andMappingClass:[CastMember class]]];
}
@end
