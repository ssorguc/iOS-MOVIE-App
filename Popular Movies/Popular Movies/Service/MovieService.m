//
//  MovieService.m
//  Popular Movies
//
//  Created by Test on 23/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "CollectionReview.h"
#import "SingleReview.h"
#import "MovieService.h"
#import <RestKit.h>
#import "VideosCollection.h"
#import "Movie.h"
#import "Actor.h"
#import "CastCollection.h"
#import "APIKeyHandling.h"
@interface MovieService(){
    NSString* apiKey;
}
@end
@implementation MovieService
- (void)getTopRatedMoviesFromAPIonSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    
    apiKey = [APIKeyHandling getAPIKeyValue];
    [[RKObjectManager sharedManager] getObject:nil path:[NSString stringWithFormat:@"/3/movie/top_rated?api_key=%@&language=en-US&page=1",apiKey] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}
- (void)geLatestMoviesFromAPIonSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    apiKey = [APIKeyHandling getAPIKeyValue];
    [[RKObjectManager sharedManager] getObject:nil path:[NSString stringWithFormat:@"/3/movie/latest?api_key=%@&language=en-US&page=1",apiKey] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}
-(void)getPopularMoviesFromAPIonSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    
    apiKey = [APIKeyHandling getAPIKeyValue];
    [[RKObjectManager sharedManager] getObject:nil path:[NSString stringWithFormat:@"/3/movie/popular?api_key=%@&language=en-US&page=1",apiKey] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}

- (void)getMovieDetailsFromAPIWithId:(NSNumber*)movieId onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    
    apiKey = [APIKeyHandling getAPIKeyValue];
    Movie *tempMovie = [Movie new];
    tempMovie.movieId = movieId;
    [[RKObjectManager sharedManager] getObject:tempMovie path:[NSString stringWithFormat:@"/3/movie/%@?api_key=%@&language=en-US",movieId,apiKey] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}

-(void)getMovieTrailerFromAPIWithId:(NSNumber *)movieId onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    
    VideosCollection *tempVideoCollection = [VideosCollection new];
    tempVideoCollection.videosId = movieId;
    apiKey = [APIKeyHandling getAPIKeyValue];
    [[RKObjectManager sharedManager] getObject:tempVideoCollection path:[NSString stringWithFormat:@"/3/movie/%@/videos?api_key=%@&language=en-US",movieId,apiKey] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}

-(void)getMovieReviewsFromAPIWithId:(NSNumber *)movieId onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    
    CollectionReview *tempCollectionReview = [CollectionReview new];
    tempCollectionReview.movieID = movieId;
    apiKey = [APIKeyHandling getAPIKeyValue];
    [[RKObjectManager sharedManager] getObject:tempCollectionReview path:[NSString stringWithFormat:@"/3/movie/%@/reviews?api_key=%@&language=en-US",movieId,apiKey] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}

-(void)getCastInformation:(NSNumber *)movieId onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    CastCollection *tempCastCollection = [CastCollection new];
    tempCastCollection.movieID = movieId;
    [[RKObjectManager sharedManager] getObject:tempCastCollection path:[NSString stringWithFormat:@"/3/movie/%@/credits?api_key=%@&language=en-US",movieId,apiKey] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}
@end
