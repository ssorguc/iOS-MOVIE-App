//
//  TVShowService.m
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "TVShow.h"
#import "TVShowService.h"
#import <RestKit.h>
#import "TVShowCollection.h"
#import "APIKeyHandling.h"
@interface TVShowService(){
    NSString* apiKey;
}
@end
@implementation TVShowService

- (void)getTVShowFromAPIonSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    apiKey = [APIKeyHandling getAPIKeyValue];
    [[RKObjectManager sharedManager] getObject:nil path:[NSString stringWithFormat:@"/3/tv/popular?api_key=%@&language=en-US&page=1",apiKey] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}

- (void)getTVShowDetailsFromAPIWithId:(NSNumber*)tvId onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    
    apiKey = [APIKeyHandling getAPIKeyValue];    TVShow *tv1 = [TVShow new];
    tv1.tvShowId = tvId;
    [[RKObjectManager sharedManager] getObject:tv1 path:[NSString stringWithFormat:@"/3/tv/%@?api_key=%@&language=en-US",tvId,apiKey] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}
@end
