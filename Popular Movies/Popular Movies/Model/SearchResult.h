//
//  SearchResult.h
//  Popular Movies
//
//  Created by Test on 28/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MappableEntity.h"
@interface SearchResult : MappableEntity
@property (nonatomic,strong) NSNumber* searchResultId;
@property (nonatomic,strong) NSString* posterPath;
@property (nonatomic,strong) NSDate* firstAirDate;
@property (nonatomic,strong) NSDate* releaseDate;
@property (nonatomic,strong) NSNumber* voteAverage;
@property (nonatomic,strong) NSString* mediaType;//results can be tv or movie type
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* title;
@end
