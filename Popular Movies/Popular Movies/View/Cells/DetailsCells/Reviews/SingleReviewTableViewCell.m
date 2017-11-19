//
//  SingleReviewTableViewCell.m
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "SingleReviewTableViewCell.h"

@interface SingleReviewTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@implementation SingleReviewTableViewCell
NSString* const singleReviewReuseIdentifier = @"singleReviewCell";
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setUpSingleReviewCellWithAuthor:(NSString*)authorString withContent:(NSString*)contentString{
    self.authorLabel.text = authorString;
    self.contentLabel.text = contentString;
}
@end
