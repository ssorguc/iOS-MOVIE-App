//
//  CrewMember.m
//  Popular Movies
//
//  Created by Test on 31/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "CrewMember.h"

@implementation CrewMember
- (NSDictionary*)registrationData {
    return @{
             @"department":_department,
             @"job":_job,
             @"name":_name
             };
}

+ (NSArray*)fieldsArrayForMapping {
    return @[ @"department",@"job",@"name"];
}

@end
