//
//  ReviewTableViewCell.m
//  Popular Movies
//
//  Created by Test on 26/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "SingleReviewTableViewCell.h"
#import "ReviewTableViewCell.h"
@interface ReviewTableViewCell()
@property (weak, nonatomic) IBOutlet ReviewsTableView *reviewsTableView;

@end
@implementation ReviewTableViewCell
NSString* const reviewReuseIdentifier = @"reviewCell";
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)setUpReviewsCellWithDelegate:(id)delegate withDataSource:(id)dataSource{
    self.reviewsTableView.delegate = delegate;
    self.reviewsTableView.dataSource = dataSource;
    [self.reviewsTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SingleReviewTableViewCell class]) bundle:nil] forCellReuseIdentifier:singleReviewReuseIdentifier];
    
    [self.reviewsTableView reloadData];
}
@end
