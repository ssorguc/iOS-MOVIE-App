//
//  DirectorWriterTableViewCell.h
//  Popular Movies
//
//  Created by Test on 09/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DirectorWriterTableViewCell : UITableViewCell
extern NSString* const directorWriterReuseIdentifier;
-(void)setUpDirectorsWritersCellWithCrew:(NSArray*)crew;
@end
