//
//  SearchResultsCollection.m
//  Popular Movies
//
//  Created by Test on 28/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "SearchResultsCollection.h"
#import "SearchResult.h"
@implementation SearchResultsCollection
- (NSDictionary*)registrationData {
    return @{
             @"total_results":_totalResults,
             @"total_pages":_totalPages
             };
}
+ (NSArray*)pathPatterns {
    return @[[NSString stringWithFormat:@"/3/search/multi"]
             ];
}
+ (NSDictionary*)fieldsDictionaryForMapping {
    return @{
             @"total_results":@"totalResults",
             @"total_pages":@"totalPages"
             };
}
+(NSArray*)keyPathes {
    return nil;
}

+(NSArray*)relationships {
    return @[[RelationshipObject relationshipWithKey:@"results" andMappingClass:[SearchResult class]]];
}
@end
