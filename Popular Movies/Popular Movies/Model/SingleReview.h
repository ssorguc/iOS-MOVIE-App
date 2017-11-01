//
//  SingleReview.h
//  Popular Movies
//
//  Created by Test on 29/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MappableEntity.h"
@interface SingleReview : MappableEntity
@property (nonatomic,strong) NSString* reviewId;
@property (nonatomic,strong) NSString* author;
@property (nonatomic,strong) NSString* content;
@property (nonatomic,strong) NSString* url;
@end
