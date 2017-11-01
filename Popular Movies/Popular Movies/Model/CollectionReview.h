//
//  CollectionReview.h
//  Popular Movies
//
//  Created by Test on 29/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "MappableEntity.h"
#import <Foundation/Foundation.h>

@interface CollectionReview : MappableEntity
@property (nonatomic,strong) NSNumber* movieID;
@property (nonatomic,strong) NSNumber* page;
@property (nonatomic,strong) NSNumber* totalPages;
@property (nonatomic,strong) NSNumber* totalResults;
@property (nonatomic,strong) NSArray* results;
@end
