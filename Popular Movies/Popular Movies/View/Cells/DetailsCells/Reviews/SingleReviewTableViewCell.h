//
//  SingleReviewTableViewCell.h
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SingleReviewTableViewCellDelegate <NSObject>

- (void)readMoreClick:(UIButton*)sender;
@end


@interface SingleReviewTableViewCell : UITableViewCell

@property (nonatomic, strong) id<SingleReviewTableViewCellDelegate> delegate;

extern NSString* const singleReviewReuseIdentifier;

-(void)setUpSingleReviewCellWithAuthor:(NSString*)authorString withContent:(NSString*)contentString isExtended:(BOOL)isExtended withIndexPath:(NSIndexPath* )indexPath;
@end
