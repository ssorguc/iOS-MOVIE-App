//
//  ImagesCollection.h
//  Popular Movies
//
//  Created by Test on 11/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MappableEntity.h"
@interface ImagesCollection : MappableEntity
@property (nonatomic,strong) NSArray* posters;
@property (nonatomic,strong) NSArray* backdrops;
@end
