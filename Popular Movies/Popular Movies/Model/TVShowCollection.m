//
//  TVShowCollection.m
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "TVShowCollection.h"
#import "TVShow.h"
#import "RelationshipObject.h"
@implementation TVShowCollection
- (NSDictionary*)registrationData {
    return @{
             @"page": _page,
             @"total_results": _totalResults,
             @"total_pages": _totalPages
             };
}
+ (NSArray*)fieldsArrayForMapping {
    return @[ @"page"];
}

+ (NSDictionary*)fieldsDictionaryForMapping {
    return @{
             @"total_results":@"totalResults",
             @"total_pages": @"totalPages" };
}
+ (NSArray*)pathPatterns {
    return @[[NSString stringWithFormat:@"/3/tv/popular"],
             [NSString stringWithFormat:@"/3/tv/top_rated"]
             ];
}

+(NSArray*)keyPathes {
    return nil;
}

+(NSArray*)relationships {
    return @[[RelationshipObject relationshipWithKey:@"results" andMappingClass:[TVShow class]]];
}
@end
