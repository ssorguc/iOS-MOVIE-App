//
//  TVShowCollection.h
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MappableEntity.h"
#import "ImagesCollection.h"
@interface TVShowCollection : MappableEntity
@property (strong, nonatomic) NSNumber* page;
@property (strong, nonatomic) NSNumber* totalResults;
@property (strong, nonatomic) NSNumber* totalPages;
@property (nonatomic,strong) NSArray* results; // RELATIONSHIP OBJECT
@end
