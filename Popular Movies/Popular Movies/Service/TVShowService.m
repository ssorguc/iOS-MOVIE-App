//
//  TVShowService.m
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "CastCollection.h"
#import "TVShow.h"
#import "TVShowService.h"
#import <RestKit.h>
#import "TVShowCollection.h"
#import "APIKeyHandling.h"
#import "VideosCollection.h"
#import "Trailer.h"
@interface TVShowService(){
    NSString* apiKey;
}
@end
@implementation TVShowService
- (void)getAiringTodayTVShowFromAPIonSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    apiKey = [APIKeyHandling getAPIKeyValue];
    [[RKObjectManager sharedManager] getObject:nil path:[NSString stringWithFormat:@"/3/tv/airing_today?api_key=%@&language=en-US&page=1",apiKey] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}
- (void)getPopularTVShowFromAPIWithPageNumber:(NSInteger)page onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    apiKey = [APIKeyHandling getAPIKeyValue];
    [[RKObjectManager sharedManager] getObject:nil path:[NSString stringWithFormat:@"/3/tv/popular?api_key=%@&language=en-US&page=%ld",apiKey,page] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}
- (void)getLatestTVShowFromAPIonSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    apiKey = [APIKeyHandling getAPIKeyValue];
    [[RKObjectManager sharedManager] getObject:nil path:[NSString stringWithFormat:@"/3/tv/latest?api_key=%@&language=en-US&page=1",apiKey] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}
- (void)getPopularTVShowFromAPIonSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    apiKey = [APIKeyHandling getAPIKeyValue];
    [[RKObjectManager sharedManager] getObject:nil path:[NSString stringWithFormat:@"/3/tv/popular?api_key=%@&language=en-US&page=1",apiKey] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}
- (void)getTopRatedTVShowsFromAPIonSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    apiKey = [APIKeyHandling getAPIKeyValue];
    [[RKObjectManager sharedManager] getObject:nil path:[NSString stringWithFormat:@"/3/tv/top_rated?api_key=%@&language=en-US&page=1",apiKey] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}

- (void)getTVShowDetailsFromAPIWithId:(NSNumber*)tvId onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    
    apiKey = [APIKeyHandling getAPIKeyValue];
    TVShow *tv1 = [TVShow new];
    tv1.tvShowId = tvId;
    [[RKObjectManager sharedManager] getObject:tv1 path:[NSString stringWithFormat:@"/3/tv/%@?api_key=%@&language=en-US",tvId,apiKey] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}
- (void)getTVShowTrailerFromAPIWithId:(NSNumber*)tvId onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    apiKey = [APIKeyHandling getAPIKeyValue];
    VideosCollection *tempVideoCollection = [VideosCollection new];
    tempVideoCollection.videosId = tvId;
    apiKey = [APIKeyHandling getAPIKeyValue];
    [[RKObjectManager sharedManager] getObject:tempVideoCollection path:[NSString stringWithFormat:@"/3/tv/%@/videos?api_key=%@&language=en-US",tvId,apiKey] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
    
}
-(void)getTVShowCastFromAPIWithId:(NSNumber *)tvId onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
        CastCollection *tempCastCollection = [CastCollection new];
        tempCastCollection.movieID = tvId;
        [[RKObjectManager sharedManager] getObject:tempCastCollection path:[NSString stringWithFormat:@"/3/tv/%@/credits?api_key=%@&language=en-US",tvId,apiKey] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            onSuccess(mappingResult);
        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
            onError(error);
        }];
    
}
-(void)getTVShowReviewsFromAPIWithId:(NSNumber *)tvId onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    
}
@end
