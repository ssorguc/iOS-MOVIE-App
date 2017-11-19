//
//  Movie.h
//  Popular Movies
//
//  Created by Test on 10/3/17.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MappableEntity.h"
#import "CollectionReview.h"
#import "VideosCollection.h"
#import "CastCollection.h"
#import "ImagesCollection.h"
@interface Movie : MappableEntity
@property (nonatomic,strong) NSNumber* voteCount;
@property (nonatomic,strong) NSNumber* movieId;
@property (nonatomic,strong) NSNumber* runtime;
@property Boolean video;
@property (nonatomic,strong) NSNumber* voteAverage;
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSNumber* popularity;
@property (nonatomic,strong) NSString* posterPath;
@property (nonatomic,strong) NSString* originalLanguage;
@property (nonatomic,strong) NSString* originalTitle;
@property (nonatomic,strong) NSString* backdropPath;
@property Boolean adult;
@property (nonatomic,strong) NSString* overview;
@property (nonatomic,strong) NSDate* releaseDate;
@property (nonatomic,strong) NSArray* genres; // RELATIONSHIP OBJECT
@property (nonatomic,strong) ImagesCollection* images;
@property (nonatomic,strong) CastCollection* credits;
@property (nonatomic,strong) VideosCollection* videos;
@property (nonatomic,strong) CollectionReview* reviews;
- (NSDictionary*)registrationData;
@end
