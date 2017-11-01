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
@implementation MovieService
- (void)getMoviesFromAPIonSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    //remove api key before commit!!
    [[RKObjectManager sharedManager] getObject:nil path:[NSString stringWithFormat:@"/3/movie/top_rated?api_key=a496788d6dd8726ab0a300f87b22a7eb&language=en-US&page=1"] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}
-(void)getPopularMoviesFromAPIonSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    [[RKObjectManager sharedManager] getObject:nil path:[NSString stringWithFormat:@"/3/movie/popular?api_key=a496788d6dd8726ab0a300f87b22a7eb&language=en-US&page=1"] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}
- (void)getMovieDetailsFromAPIWithId:(NSNumber*)movieId onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    //remove api key before commit!!
    Movie *movie = [Movie new];
    movie.movieId = movieId;
    [[RKObjectManager sharedManager] getObject:movie path:[NSString stringWithFormat:@"/3/movie/%@?api_key=a496788d6dd8726ab0a300f87b22a7eb&language=en-US",movieId] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}
-(void)getMovieTrailerFromAPIWithId:(NSNumber *)movieId onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    VideosCollection *v = [VideosCollection new];
    v.videosId = movieId;
    [[RKObjectManager sharedManager] getObject:v path:[NSString stringWithFormat:@"/3/movie/%@/videos?api_key=a496788d6dd8726ab0a300f87b22a7eb&language=en-US",movieId] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}
-(void)getMovieReviewsFromAPIWithId:(NSNumber *)movieId onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    CollectionReview *rv = [CollectionReview new];
    rv.movieID = movieId;
    [[RKObjectManager sharedManager] getObject:rv path:[NSString stringWithFormat:@"/3/movie/%@/reviews?api_key=a496788d6dd8726ab0a300f87b22a7eb&language=en-US",movieId] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}

-(void)getCastInformation:(NSNumber *)movieId onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    CastCollection *cast1 = [CastCollection new];
    cast1.movieID = movieId;
    [[RKObjectManager sharedManager] getObject:cast1 path:[NSString stringWithFormat:@"/3/movie/%@/credits?api_key=a496788d6dd8726ab0a300f87b22a7eb&language=en-US",movieId] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}
@end
