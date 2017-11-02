//
//  CollectionReview.m
//  Popular Movies
//
//  Created by Test on 29/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "RelationshipObject.h"
#import "SingleReview.h"
#import "CollectionReview.h"
/*"id": 346364,
 "page": 1
 "total_pages": 2,
 "total_results": 7*/
@implementation CollectionReview
- (NSDictionary*)registrationData {
    return @{
             @"id":_movieID,
             @"page":_page,
             @"total_pages":_totalPages,
             @"total_results": _totalResults
             };
}

+ (NSDictionary*)fieldsDictionaryForMapping {
    return @{
             @"id":@"movieID",
             @"total_pages":@"totalPages",
             @"total_results": @"totalResults"
             };
}

+ (NSArray*)fieldsArrayForMapping {
    return @[ @"page"];
}

+(NSArray*)keyPathes {
    return nil;
}

+ (NSArray*)pathPatterns {
    return @[@"/3/movie/:movieId/reviews"];
}

+(NSArray*)relationships {
    return @[[RelationshipObject relationshipWithKey:@"results" andMappingClass:[SingleReview class]]];
}
@end
