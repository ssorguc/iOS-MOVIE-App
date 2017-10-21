//
//  Movie.h
//  Popular Movies
//
//  Created by Test on 10/3/17.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Date.h"
@interface Movie : NSObject
@property (nonatomic,strong) NSString* movieTitle;
@property (nonatomic,strong) NSArray* movieGenre;
@property (nonatomic,strong) Date* dateOfPublishing;
@property (nonatomic) NSInteger ratingNumber;
@property (nonatomic,strong) NSArray* castArray;
@property (nonatomic,strong) NSString* director;
@property (nonatomic,strong) NSArray* writers;
@property (nonatomic,strong) NSString* country;
@property (nonatomic,strong) NSArray* stars;
@end
