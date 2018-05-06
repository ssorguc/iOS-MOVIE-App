//
//  SingleReviewTableViewCell.m
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "SingleReviewTableViewCell.h"

@interface SingleReviewTableViewCell()

@property (weak, nonatomic) IBOutlet UIButton *readMoreButton;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation SingleReviewTableViewCell

CGFloat maxContentLabelHeight = 100.0;

NSString* const singleReviewReuseIdentifier = @"singleReviewCell";

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setUpSingleReviewCellWithAuthor:(NSString*)authorString withContent:(NSString*)contentString isExtended:(BOOL)isExtended withIndexPath:(NSIndexPath*) indexPath{
    self.authorLabel.text = authorString;
    self.contentLabel.text = contentString;
    self.contentLabel.numberOfLines = 0;
    [self.contentLabel sizeToFit];
    
    if(!isExtended && CGRectGetHeight(self.contentLabel.bounds) > maxContentLabelHeight){
        self.contentLabel.numberOfLines = 5;
        self.contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    else{
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    [self.readMoreButton addTarget:self action:@selector(readMoreReview) forControlEvents:UIControlEventTouchUpInside];
   
}

-(void)readMoreReview{
    if (self.delegate && [self.delegate respondsToSelector:@selector(readMoreClick                                                                     :)]) {
        [self.delegate readMoreClick:self.readMoreButton];
    }
}
@end
