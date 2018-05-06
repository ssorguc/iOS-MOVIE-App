//
//  SearchService.h
//  Popular Movies
//
//  Created by Test on 28/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APICallbacks.h"
@interface SearchService : NSObject
- (void)searchMoviesAndTVShowsWithPage:(NSInteger)page withQueryString:(NSString*)searchString onSuccess:(SuccessCallbackWithObject)onSuccess onError:(ErrorCallback)onError;
@end
