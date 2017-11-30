//
//  TVShow.m
//  Popular Movies
//
//  Created by Test on 10/3/17.
//  Copyright © 2017 Test. All rights reserved.
//
#import "Genre.h"
#import "TVShow.h"
#import "RelationshipObject.h"
#import "SingleSeason.h"
#import "CreatedBy.h"
@implementation TVShow
- (NSDictionary*)registrationData {
    return @{
         @"original_name": _originalName,
         @"name": _name,
         @"popularity": _popularity,
         @"vote_count": _voteCount,
         @"first_air_date":_firstAirDate ,
         @"backdrop_path": _backdropPath,
         @"original_language": _originalLanguage,
         @"id":_tvShowId ,
         @"vote_average":_voteAverage ,
         @"overview":_overview ,
         @"poster_path":_posterPath,
         @"last_air_date":_lastAirDate,
         @"number_of_episodes":_numberOfEpisodes,
         @"number_of_seasons":_numberOfSeasons
             };
}

+ (NSArray*)fieldsArrayForMapping {
    return @[ @"name", @"popularity",@"overview"];
}

+ (NSDictionary*)fieldsDictionaryForMapping {
    return @{
             @"vote_count": @"voteCount",
             @"vote_average": @"voteAverage" ,
             @"poster_path":@"posterPath",
             @"original_language":@"originalLanguage",
             @"backdrop_path":@"backdropPath",
             @"first_air_date":@"firstAirDate",
             @"original_name": @"originalName",
             @"id":@"tvShowId",@"last_air_date":@"lastAirDate",
             @"number_of_episodes":@"numberOfEpisodes",
             @"number_of_seasons":@"numberOfSeasons"
             };
}
+(NSArray*)keyPathes {
    return nil;
}
+ (NSArray*)pathPatterns {
    return @[@"/3/tv/:tvId"
             ];
}
+(NSArray*)relationships {
    return @[ //[RelationshipObject relationshipWithKey:@"created_by" andMappingClass:[CreatedBy class]],
              [RelationshipObject relationshipWithKey:@"seasons" andMappingClass:[SingleSeason class]],
              [RelationshipObject relationshipWithKey:@"genres" andMappingClass:[Genre class]],
              [RelationshipObject relationshipWithKey:@"images" andMappingClass:[ImagesCollection class]]];
}
@end
