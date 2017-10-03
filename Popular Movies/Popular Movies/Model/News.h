//
//  News.h
//  Popular Movies
//
//  Created by Test on 10/3/17.
//  Copyright © 2017 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
{
    NSString *title;
    NSString *text;
    NSString *source_link;
}

@property (strong, nonatomic) NSString* title;
@property (strong,nonatomic) NSString* text;
@property (strong,nonatomic) NSString* source_link;

@end
