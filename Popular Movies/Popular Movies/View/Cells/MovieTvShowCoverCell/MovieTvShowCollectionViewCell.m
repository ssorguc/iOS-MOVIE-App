//
//  MovieTvShowCollectionViewCell.m
//  Popular Movies
//
//  Created by Test on 16/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "MovieTvShowCollectionViewCell.h"
#import "Gradient.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TVShow.h"

@interface MovieTvShowCollectionViewCell()
@property (weak, nonatomic) CAGradientLayer *bottomBox;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end

@implementation MovieTvShowCollectionViewCell
NSString * const movieTVShowReuseIdentifier = @"MovieTVShowCell";

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    if (_bottomBox == nil) {
        _bottomBox = [Gradient setUpGradient];
        [self.coverImageView.layer addSublayer:_bottomBox];
    }
    _bottomBox.frame = self.coverImageView.bounds;
}
-(void)setUpMovieTvShowCollectionViewCellWithTitle:(NSString*)title imageLink:(NSString*)posterPath releaseDate:(NSDate*)date rating:(NSNumber*)voteAverage{
    //Setting up the cover image of the cell
    NSString* imageLink = [@"http://image.tmdb.org/t/p/w185/" stringByAppendingString: posterPath];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString: imageLink] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    //Setting up the vote average text for label
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode: NSNumberFormatterRoundUp];
    self.ratingLabel.text = [formatter stringFromNumber: voteAverage];
    //Setting up the title
    self.titleLabel.text = [title uppercaseString];
    //Detting up the date
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"dd.MM.yyyy"];
    NSString *result = [df stringFromDate:date];
    self.dateLabel.text = result;
}
@end
