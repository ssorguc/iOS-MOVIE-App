//
//  SingleReviewTableViewCell.h
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleReviewTableViewCell : UITableViewCell
-(void)setUpSingleReviewCellWithAuthor:(NSString*)authorString withContent:(NSString*)contentString;
extern NSString* const singleReviewReuseIdentifier;
@end
