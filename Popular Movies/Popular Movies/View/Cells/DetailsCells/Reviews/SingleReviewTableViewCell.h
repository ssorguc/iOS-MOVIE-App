//
//  SingleReviewTableViewCell.h
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleReviewTableViewCell : UITableViewCell
extern NSString* const singleReviewReuseIdentifier;
-(void)setUpSingleReviewCellWithAuthor:(NSString*)authorString withContent:(NSString*)contentString;
@end
