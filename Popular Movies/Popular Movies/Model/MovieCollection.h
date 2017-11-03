//
//  MovieCollection.h
//  Popular Movies
//
//  Created by Test on 24/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RelationshipObject.h"
#import "MappableEntity.h"
@interface MovieCollection :MappableEntity
@property (nonatomic,strong)NSNumber* page;
@property (nonatomic,strong) NSNumber* totalResults;
@property (nonatomic,strong) NSNumber* totalPages;
@property (nonatomic,strong) NSArray* results; // RELATIONSHIP OBJECT
@end
