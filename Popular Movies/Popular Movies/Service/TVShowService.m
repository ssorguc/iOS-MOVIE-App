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

@implementation TVShowService
- (void)getTVShowFromAPIonSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    [[RKObjectManager sharedManager] getObject:nil path:[NSString stringWithFormat:@"/3/tv/popular?api_key=a496788d6dd8726ab0a300f87b22a7eb&language=en-US&page=1"] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}

- (void)getTVShowDetailsFromAPIWithId:(NSNumber*)tvId onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    //remove api key before commit!!
    TVShow *tv1 = [TVShow new];
    tv1.tvShowId = tvId;
    [[RKObjectManager sharedManager] getObject:tv1 path:[NSString stringWithFormat:@"/3/tv/%@?api_key=a496788d6dd8726ab0a300f87b22a7eb&language=en-US",tvId] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}
@end
