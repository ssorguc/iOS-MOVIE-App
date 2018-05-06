//
//  Gradient.m
//  Popular Movies
//
//  Created by Test on 26/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "Gradient.h"
#import <UIKit/UIKit.h>

@implementation Gradient
+(CAGradientLayer*)setUpGradient{
    CAGradientLayer* bottomBox = [CAGradientLayer layer];
    UIColor* one = [UIColor clearColor];
    UIColor* two = [UIColor blackColor];
    NSArray* colors = [NSArray arrayWithObjects:(id)one.CGColor,two.CGColor, nil];
    NSNumber* stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber* stopTwo = [NSNumber numberWithFloat:0.9];
    NSArray* locations = [NSArray arrayWithObjects:stopOne,stopTwo, nil];
    bottomBox.colors = colors;
    bottomBox.locations = locations;
    return bottomBox;
}
+(CAGradientLayer*)setUpActorsGradient{
    CAGradientLayer* bottomBox = [CAGradientLayer layer];
    UIColor* one = [UIColor clearColor];
    UIColor* two = [UIColor blackColor];
    NSArray* colors = [NSArray arrayWithObjects:(id)one.CGColor,two.CGColor, nil];
    NSNumber* stopOne = [NSNumber numberWithFloat:0.4];
    NSNumber* stopTwo = [NSNumber numberWithFloat:0.95];
    NSArray* locations = [NSArray arrayWithObjects:stopOne,stopTwo, nil];
    bottomBox.colors = colors;
    bottomBox.locations = locations;
    return bottomBox;
}
@end
