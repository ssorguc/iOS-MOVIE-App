//
//  TVShow.h
//  Popular Movies
//
//  Created by Test on 10/3/17.
//  Copyright © 2017 Test. All rights reserved.
//
#import "ImagesCollection.h"
#import "MappableEntity.h"
#import <Foundation/Foundation.h>
@interface TVShow : MappableEntity
@property (nonatomic,strong) NSString* originalName;
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSNumber* popularity;
@property (nonatomic,strong) NSNumber* voteCount;
@property (nonatomic,strong) NSDate* firstAirDate;
@property (nonatomic,strong) NSString* backdropPath;
@property (nonatomic,strong) NSString* originalLanguage;
@property (nonatomic,strong) NSNumber* tvShowId;
@property (nonatomic,strong) NSNumber* voteAverage;
@property (nonatomic,strong) NSString* overview;
@property (nonatomic,strong) NSString* posterPath;
@property (nonatomic,strong) NSArray* genres;// RELATIONSHIP OBJECT
@property (nonatomic,strong) NSArray* createdBy;// RELATIONSHIP OBJECT
@property (nonatomic,strong) NSNumber* numberOfEpisodes;
@property (nonatomic,strong) NSNumber* numberOfSeasons;
@property (nonatomic,strong) NSDate* lastAirDate;
@property (nonatomic,strong) NSArray* seasons;// RELATIONSHIP OBJECT
@property (nonatomic,strong) ImagesCollection *images;

@end
