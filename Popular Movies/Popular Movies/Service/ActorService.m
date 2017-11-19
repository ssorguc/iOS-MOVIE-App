//
//  ActorService.m
//  Popular Movies
//
//  Created by Test on 19/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "APIKeyHandling.h"
#import <RestKit.h>
#import "ActorService.h"
@interface ActorService()
{
    NSString* apiKey;
}
@end
@implementation ActorService
- (void)getActorInformation:(NSNumber*)actorId onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError{
    apiKey = [APIKeyHandling getAPIKeyValue];
    [[RKObjectManager sharedManager] getObject:nil path:[NSString stringWithFormat:@"/3/person/%@?api_key=%@&language=en-US",actorId,apiKey] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        onSuccess(mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        onError(error);
    }];
}
@end
