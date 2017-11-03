//
//  MappableEntity.h
//  Popular Movies
//
//  Created by Test on 23/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MappableEntity : NSObject
+ (NSArray*)pathPatterns;
+ (NSArray*)keyPathes;
+ (NSArray*)fieldsArrayForMapping;
+ (NSDictionary*)fieldsDictionaryForMapping;
+ (NSArray*)relationships;
@end
