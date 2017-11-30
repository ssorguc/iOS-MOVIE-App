//
//  SearchResult.m
//  Popular Movies
//
//  Created by Test on 28/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "SearchResult.h"

@implementation SearchResult
- (NSDictionary*)registrationData {
    return @{
             @"name": _name,
             @"id":_searchResultId,
             @"media_type":_mediaType,
             @"vote_average":_voteAverage,
             @"poster_path":_posterPath,
             @"tite":_title,
             @"first_air_date":_firstAirDate,
             @"release_date":_releaseDate
             };
}

+ (NSArray*)fieldsArrayForMapping {
    return @[ @"name",@"title",];
}
+ (NSDictionary*)fieldsDictionaryForMapping {
    return @{
             @"id":@"searchResultId",
             @"media_type":@"mediaType",
             @"vote_average":@"voteAverage",
             @"poster_path":@"posterPath",
             @"first_air_date":@"firstAirDate",
             @"release_date":@"releaseDate"
             };
}
@end
