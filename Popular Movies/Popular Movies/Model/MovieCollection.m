//
//  MovieCollection.m
//  Popular Movies
//
//  Created by Test on 24/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "MovieCollection.h"
#import "Movie.h"
@implementation MovieCollection

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
    return @[[NSString stringWithFormat:@"/3/movie/popular"],
             [NSString stringWithFormat:@"/3/movie/top_rated"],
             [NSString stringWithFormat:@"/3/movie/now_playing"]
             ];
}

+(NSArray*)keyPathes {
    return nil;
}

+(NSArray*)relationships {
    return @[[RelationshipObject relationshipWithKey:@"results" andMappingClass:[Movie class]]];
}
@end
