//
//  Movie.h
//  Popular Movies
//
//  Created by Test on 10/3/17.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

//This class is a mdel for a single movie
@interface Movie : NSObject
//Add the properties which will be mapped with related JSON from API
@property int id;
@property NSNumber* popularity;
@property NSString* title;
@property NSDate* releaseDate;
@property NSArray* generes;
@property NSNumber* voteAverage;
@end
