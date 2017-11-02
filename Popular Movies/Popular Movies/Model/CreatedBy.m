//
//  CreatedBy.m
//  Popular Movies
//
//  Created by Test on 29/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "CreatedBy.h"
/*"id": 4027,
 "name": "Frank Darabont",
 "gender": 2,
 "profile_path": "/9KVvZtDyy8DXacw2TTsjC9VLxQi.jpg"*/
@implementation CreatedBy
- (NSDictionary*)registrationData {
    return @{
             @"id":_creatorId,
             @"name":_name,
             @"gender": _gender,
             @"profile_path":_profilePath
             };
}

+ (NSArray*)fieldsArrayForMapping {
    return @[ @"id",@"name",@"gender"];
}
+ (NSDictionary*)fieldsDictionaryForMapping {
    return @{
             @"profile_path": @"profilePath"
             };
}
@end
