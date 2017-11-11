//
//  SingleImage.h
//  Popular Movies
//
//  Created by Test on 11/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MappableEntity.h"
@interface SingleImage : MappableEntity
@property (nonatomic,strong) NSString* filePath;
@property (nonatomic,strong) NSNumber* height;
@property (nonatomic,strong) NSNumber* width;
@end
