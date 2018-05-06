//
//  CastMember.m
//  Popular Movies
//
//  Created by Test on 22/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "CastMember.h"

@implementation CastMember
- (NSDictionary*)registrationData {
    return @{
             @"poster_path":_posterPath,
             @"title":_title,
             @"character":_character
             };
}

+ (NSArray*)fieldsArrayForMapping {
    return @[ @"title",@"character"];
}
+ (NSDictionary*)fieldsDictionaryForMapping {
    return @{
             @"poster_path": @"posterPath"
             };
}
@end
