//
//  VideosCollection.m
//  Popular Movies
//
//  Created by Test on 28/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "RelationshipObject.h"
#import "Trailer.h"
#import "VideosCollection.h"

@implementation VideosCollection
- (NSDictionary*)registrationData {
    return @{
             @"id":_videosId,
             };
}
+ (NSArray*)pathPatterns {
    return @[[NSString stringWithFormat:@"/3/movie/:movieId/videos"],
             [NSString stringWithFormat:@"/3/tv/:tvId/videos"]
             ];
}
+ (NSDictionary*)fieldsDictionaryForMapping {
    return @{
             @"id":@"videosId"
             };
}
+(NSArray*)keyPathes {
    return nil;
}

+(NSArray*)relationships {
    return @[[RelationshipObject relationshipWithSource:@"results" destination:@"videoResults" andMappingClass:[Trailer class]]];
}
@end
