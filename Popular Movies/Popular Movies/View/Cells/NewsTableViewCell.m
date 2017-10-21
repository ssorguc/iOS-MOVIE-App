//
//  NewsTableViewCell.m
//  Popular Movies
//
//  Created by Test on 11/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "NewsTableViewCell.h"

@interface NewsTableViewCell()
@end

@implementation NewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _backgroundBox.layer.cornerRadius=4;

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
