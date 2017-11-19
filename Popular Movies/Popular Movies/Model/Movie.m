//
//  Movie.m
//  Popular Movies
//
//  Created by Test on 10/3/17.
//  Copyright © 2017 Test. All rights reserved.
//
#import "ImagesCollection.h"
#import "Genre.h"
#import "Movie.h"
#import <RestKit.h>
#import "RelationshipObject.h"
@implementation Movie
- (NSDictionary*)registrationData {
    return @{
             @"vote_count":_voteCount,
             @"id":_movieId,
            // @"video":_video,
             @"vote_average":_voteAverage,
             @"title": _title,
             @"popularity": _popularity,
             @"poster_path":_posterPath,
             @"original_language":_originalLanguage,
             @"original_title":_originalTitle,
             @"backdrop_path":_backdropPath,
             @"overview":_overview,
             @"runtime":_runtime,
             @"release_date":_releaseDate
             };
}

+ (NSArray*)fieldsArrayForMapping {
    return @[  @"video",@"title", @"popularity", @"overview",@"runtime"];
}

+ (NSDictionary*)fieldsDictionaryForMapping {
    return @{
             @"id": @"movieId",
             @"vote_count": @"voteCount",
             @"vote_average": @"voteAverage" ,
             @"poster_path":@"posterPath",
             @"original_language":@"originalLanguage",
             @"original_title":@"originalTitle",
             @"backdrop_path":@"backdropPath",
             @"release_date":@"releaseDate"
          };
}
+(NSArray*)keyPathes {
    return nil;
}
+ (NSArray*)pathPatterns {
    return @[@"/3/movie/:movieId"
             ];
}
+(NSArray*)relationships {
    return @[[RelationshipObject relationshipWithKey:@"genres" andMappingClass:[Genre class]],
             [RelationshipObject relationshipWithKey:@"images" andMappingClass:[ImagesCollection class]],
             [RelationshipObject relationshipWithSource:@"videos" destination:@"videos" andMappingClass:[VideosCollection class]],
             [RelationshipObject relationshipWithSource:@"credits" destination:@"credits" andMappingClass:[CastCollection class]],
             [RelationshipObject relationshipWithSource:@"reviews" destination:@"reviews" andMappingClass:[CollectionReview class]]];
}
@end
