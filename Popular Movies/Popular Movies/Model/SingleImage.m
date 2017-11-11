//
//  SingleImage.m
//  Popular Movies
//
//  Created by Test on 11/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "SingleImage.h"

@implementation SingleImage
- (NSDictionary*)registrationData {
    return @{
             @"file_path":_filePath,
             @"height":_height,
             @"width":_width
             };
}

+ (NSArray*)fieldsArrayForMapping {
    return @[ @"height",@"width"];
}
+ (NSDictionary*)fieldsDictionaryForMapping {
    return @{
             @"file_path": @"filePath"
             };
}
@end
