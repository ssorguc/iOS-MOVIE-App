//
//  SingleReview.m
//  Popular Movies
//
//  Created by Test on 29/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "SingleReview.h"

@implementation SingleReview
/*"id": "59cfdca4925141141e00215a",
 "author":
 content
 url*/
- (NSDictionary*)registrationData {
    return @{
             @"id": _reviewId,
             @"author":_author,
             @"content":_content,
             @"url": _url
             };
}

+ (NSArray*)fieldsArrayForMapping {
    return @[ @"author", @"content",@"url"];
}

+ (NSDictionary*)fieldsDictionaryForMapping {
    return @{
              @"id": @"reviewId"
             };
}
@end
