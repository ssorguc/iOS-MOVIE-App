//
//  ActorService.h
//  Popular Movies
//
//  Created by Test on 19/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APICallbacks.h"

@interface ActorService : NSObject
- (void)getActorInformation:(NSNumber*)actorId onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError;
@end
