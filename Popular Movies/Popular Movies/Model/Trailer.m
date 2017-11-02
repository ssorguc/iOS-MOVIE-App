//
//  Trailer.m
//  Popular Movies
//
//  Created by Test on 28/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "Trailer.h"

@implementation Trailer
- (NSDictionary*)registrationData {
    return @{
             @"id":_trailerId,
             @"key":_key,
             @"type":_type
             };
}
+ (NSArray*)fieldsArrayForMapping {
    return @[ @"key",@"type"];
}

+ (NSDictionary*)fieldsDictionaryForMapping {
    return @{
             @"id":@"trailerId" };
}
@end
