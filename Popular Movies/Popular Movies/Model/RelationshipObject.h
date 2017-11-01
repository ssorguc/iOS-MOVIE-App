//
//  RelationshipObject.h
//  Popular Movies
//
//  Created by Test on 24/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RelationshipObject : NSObject

@property (nonatomic,copy) NSString* source;
@property (nonatomic,copy) NSString* destination;
@property (nonatomic) Class mappingClass;

+(RelationshipObject*)relationshipWithKey:(NSString*)key andMappingClass:(Class)mappingClass;
+(RelationshipObject*)relationshipWithSource:(NSString*)source destination:(NSString*)destination andMappingClass:(Class)mappingClass;

@end
