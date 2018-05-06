//
//  SearchService.m
//  Popular Movies
//
//  Created by Test on 28/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import <RestKit.h>
#import "APIKeyHandling.h"
#import "SearchService.h"
@interface SearchService()
{
    NSString * apiKey;
}
@end
@implementation SearchService
- (void)searchMoviesAndTVShowsWithPage:(NSInteger)page withQueryString:(NSString*)searchString onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    apiKey = [APIKeyHandling getAPIKeyValue];
    searchString = [searchString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    [[RKObjectManager sharedManager] getObject:nil path:[NSString stringWithFormat:@"/3/search/multi?api_key=%@&language=en-US&query=%@&page=%ld&include_adult=false",apiKey,searchString, page] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
    
    {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
    
}

@end
