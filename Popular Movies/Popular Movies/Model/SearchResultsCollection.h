//
//  SearchResultsCollection.h
//  Popular Movies
//
//  Created by Test on 28/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MappableEntity.h"
#import "RelationshipObject.h"
@interface SearchResultsCollection : MappableEntity
@property (nonatomic,strong) NSNumber* totalResults;
@property (nonatomic,strong) NSNumber* totalPages;
@property (nonatomic,strong) NSArray* results;
@end
