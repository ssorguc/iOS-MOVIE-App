//
//  MovieService.h
//  Popular Movies
//
//  Created by Test on 23/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APICallbacks.h"
@interface MovieService : NSObject
- (void)getTopRatedMoviesFromAPIonSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError;
- (void)getPopularMoviesFromAPIonSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError;
- (void)getMovieDetailsFromAPIWithId:(NSNumber*)movieId onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError;
- (void)getMovieTrailerFromAPIWithId:(NSNumber*)movieId onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError;
- (void)getMovieReviewsFromAPIWithId:(NSNumber*)movieId onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError;
- (void)getCastInformation:(NSNumber*)movieId onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError;
@end
