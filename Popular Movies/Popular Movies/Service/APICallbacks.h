//
//  APICallbacks.h
//  Popular Movies
//
//  Created by Test on 23/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#ifndef APICallbacks_h
#define APICallbacks_h

typedef void(^SuccessCallback)(void);
typedef void(^SuccessCallbackWithObjects)(NSArray *objects);
typedef void(^SuccessCallbackWithObject)(NSObject *object);
typedef void(^ErrorCallback)(NSError *error);
typedef void(^ProgressBlock)(float progress);
#endif /* APICallbacks_h */
