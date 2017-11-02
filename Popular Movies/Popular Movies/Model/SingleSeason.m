//
//  SingleSeason.m
//  Popular Movies
//
//  Created by Test on 29/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "SingleSeason.h"

@implementation SingleSeason
- (NSDictionary*)registrationData {
    return @{
             @"air_date": _airDate,
             @"episode_count": _episodeCount,
             @"id": _showId,
             @"poster_path": _posterPath,
             @"season_number":_seasonNumber
             };
}


+ (NSDictionary*)fieldsDictionaryForMapping {
    return @{
             @"air_date": @"airDate",
             @"episode_count": @"episodeCount",
             @"id": @"showId",
             @"poster_path": @"posterPath",
             @"season_number":@"seasonNumber"
             };
}
@end
