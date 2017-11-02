//
//  RelationshipObject.m
//  Popular Movies
//
//  Created by Test on 24/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "RelationshipObject.h"

@implementation RelationshipObject
+(RelationshipObject*)relationshipWithKey:(NSString*)key andMappingClass:(Class)mappingClass {
    RelationshipObject* object = [[RelationshipObject alloc] init];
    object.source = key;
    object.destination = key;
    object.mappingClass = mappingClass;
    return object;
}

+(RelationshipObject*)relationshipWithSource:(NSString*)source destination:(NSString*)destination andMappingClass:(Class)mappingClass {
    RelationshipObject* object = [[RelationshipObject alloc] init];
    object.source = source;
    object.destination = destination;
    object.mappingClass = mappingClass;
    return object;
}
@end
