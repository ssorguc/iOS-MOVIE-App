//
//  Date.m
//  Popular Movies
//
//  Created by Test on 14/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "Date.h"

@implementation Date
@synthesize day = _day;
@synthesize month = _month;
@synthesize year = _year;

-(void)setDay:(NSInteger)day{
    if(day<=1 && day>=31) day = _day;
    else day = 0; //Could later on change this logic to do something like error handling
}

-(void)setMonth:(NSInteger)month{
    if(month<=1 && month>=12)month = _month;
    else month = 0;//Could later on change this logic to do something like error handling
}
@end
