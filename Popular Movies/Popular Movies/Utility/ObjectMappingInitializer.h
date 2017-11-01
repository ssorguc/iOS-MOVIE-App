//
//  ObjectMappingInitializer.h
//  Popular Movies
//
//  Created by Test on 23/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit.h>

@interface ObjectMappingInitializer : NSObject
+(void)initializeRKObjectManagerMapping:(RKObjectManager*)objectManager;
@end
