//
//  TVShowService.h
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APICallbacks.h"
@interface TVShowService : NSObject
- (void)getTVShowFromAPIonSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError;
- (void)getTVShowDetailsFromAPIWithId:(NSNumber*)tvId onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError;
@end
