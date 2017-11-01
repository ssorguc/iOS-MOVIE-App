//
//  VideosCollection.h
//  Popular Movies
//
//  Created by Test on 28/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MappableEntity.h"

@interface VideosCollection : MappableEntity
@property (nonatomic,strong) NSNumber* videosId;
@property (nonatomic,strong) NSArray* videoResults;
@end
