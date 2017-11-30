//
//  SearchResultTableViewCell.m
//  Popular Movies
//
//  Created by Test on 24/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import <SDWebImage/UIImageView+WebCache.h>
#import "SearchResultTableViewCell.h"
@interface SearchResultTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *voteAverageLabel;

@end
NSString* const searchResultReuseIdentifier = @"searchCell";

@implementation SearchResultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)setUpSearchResultCellWithTitle:(NSString*)title withDate:(NSDate*)date withVoteAverage:(NSNumber*)voteAverage withPosterPath:(NSString*)posterPath{
    //Setting up the title
    self.titleLabel.text = title;
    //Setting up the poster image of the cell
    if(posterPath!=nil){
        NSString* imageLink = [@"http://image.tmdb.org/t/p/w185/" stringByAppendingString: posterPath];
        [self.posterImageView sd_setImageWithURL:[NSURL URLWithString: imageLink] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    //Setting up the vote average text for label
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode: NSNumberFormatterRoundUp];
    self.voteAverageLabel.text = [formatter stringFromNumber: voteAverage];
    
    //Setting up the date label
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    //Release date label
    [df setDateFormat:@"d MMMM yyyy"];
    self.dateLabel.text = [df stringFromDate:date];
    
}
@end
