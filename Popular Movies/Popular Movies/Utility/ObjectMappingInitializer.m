//
//  ObjectMappingInitializer.m
//  Popular Movies
//
//  Created by Test on 23/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "CastMember.h"
#import "SingleImage.h"
#import "CrewMember.h"
#import "SearchResult.h"
#import "SearchResultsCollection.h"
#import "MovieCollection.h"
#import "CastCollection.h"
#import "ObjectMappingInitializer.h"
#import "Movie.h"
#import "TVShow.h"
#import "Trailer.h"
#import "VideosCollection.h"
#import "Genre.h"
#import "Actor.h"
#import "SingleSeason.h"
#import "CreatedBy.h"
#import "CollectionReview.h"
#import "SingleReview.h"
#import "RelationshipObject.h"
#import "TVShowCollection.h"
#import "ImagesCollection.h"
#import "MovieCredits.h"
@interface ObjectMappingInitializer (Private)

+ (NSArray*)mappableClasses;

@end

@implementation ObjectMappingInitializer
+(void)initializeRKObjectManagerMapping:(RKObjectManager*)objectManager {
    NSMutableDictionary *mappingObjects = [NSMutableDictionary dictionary];
    
    // Creating mappings for classes
    for (Class mappableClass in [self mappableClasses]) {
        RKObjectMapping *newMapping = [RKObjectMapping mappingForClass:mappableClass];
        [newMapping addAttributeMappingsFromArray:[mappableClass fieldsArrayForMapping]];
        [newMapping addAttributeMappingsFromDictionary:[mappableClass fieldsDictionaryForMapping]];
        [mappingObjects setObject:newMapping forKey:[mappableClass description]];
    }
    
    // Creating relations for mappings
    for (Class mappableClass in [self mappableClasses]) {
        RKObjectMapping *mapping = [mappingObjects objectForKey:[mappableClass description]];
        for (RelationshipObject *relation in [mappableClass relationships]) {
            [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:relation.source toKeyPath:relation.destination withMapping:[mappingObjects objectForKey:[relation.mappingClass description]]]];
        }
    }
    
    // Creating response descriptors with mappings
    for (Class mappableClass in [self mappableClasses]) {
        for (NSString* pathPattern in [mappableClass pathPatterns]) {
            if ([mappableClass keyPathes]) {
                for (NSString* keyPath in [mappableClass keyPathes]) {
                    [objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[mappingObjects objectForKey:[mappableClass description]] method:RKRequestMethodAny pathPattern:pathPattern keyPath:keyPath statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
                }
            } else {
                [objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[mappingObjects objectForKey:[mappableClass description]] method:RKRequestMethodAny pathPattern:pathPattern keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
            }
        }
    }
    
}
@end

@implementation ObjectMappingInitializer (Private)

+ (NSArray*)mappableClasses {
    return @[
             [Genre class],
             [Movie class],
             [TVShow class],
             [Trailer class],
             [Actor class],
             [CastMember class],
             [CrewMember class],
             [SearchResult class],
             [SingleReview class],
             [SingleSeason class],
             [CreatedBy class],
             [SingleImage class],
             [MovieCollection class],
             [TVShowCollection class],
             [CastCollection class],
             [VideosCollection class],
             [CollectionReview class],
             [ImagesCollection class],
             [MovieCredits class],
             [SearchResultsCollection class]
             ];
}
@end
