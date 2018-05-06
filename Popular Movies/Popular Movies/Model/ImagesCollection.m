//
//  ImagesCollection.m
//  Popular Movies
//
//  Created by Test on 11/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "ImagesCollection.h"
#import "SingleImage.h"
#import "RelationshipObject.h"
@implementation ImagesCollection
+(NSArray*)relationships {
    return @[[RelationshipObject relationshipWithKey:@"backdrops" andMappingClass:[SingleImage class]],
             [RelationshipObject relationshipWithKey:@"posters" andMappingClass:[SingleImage class]]];
}
@end
