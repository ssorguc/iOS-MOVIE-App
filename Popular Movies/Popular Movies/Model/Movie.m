//
//  Movie.m
//  Popular Movies
//
//  Created by Test on 10/3/17.
//  Copyright © 2017 Test. All rights reserved.
//

#import "Movie.h"

@implementation Movie
@synthesize ratingNumber = _ratingNumber;

-(void)setRatingNumber:(NSInteger)ratingNumber{
    if(ratingNumber>=10)_ratingNumber = ratingNumber;
    else ratingNumber = 0; //Could later on change this logic to do something like error handling
}
@end
