//
//  Genre.m
//  Popular Movies
//
//  Created by Test on 26/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "Genre.h"

@implementation Genre
- (NSDictionary*)registrationData {
    return @{
             @"id":_genreId,
             @"name":_name
             };
}

+ (NSArray*)fieldsArrayForMapping {
    return @[ @"name"];
}
+ (NSDictionary*)fieldsDictionaryForMapping {
    return @{
             @"id": @"genreId"
             };
}

@end
