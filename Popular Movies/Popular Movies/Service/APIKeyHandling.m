//
//  APIKeyHandling.m
//  Popular Movies
//
//  Created by Test on 01/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "APIKeyHandling.h"

@implementation APIKeyHandling
+(NSString*)getAPIKeyValue{
    NSString *path = [[NSBundle mainBundle] pathForResource: @"APIKey" ofType: @"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
    NSString* apikey = [dict objectForKey: @"APIKey"];
    return apikey;
}
@end
