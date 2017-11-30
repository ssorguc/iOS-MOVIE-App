//
//  MovieDescriptionTableViewCell.m
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "CrewMember.h"
#import "MovieDescriptionTableViewCell.h"
@interface MovieDescriptionTableViewCell()
{
    NSString* allWriters;
    NSString* allDirectors;
}
@property (weak, nonatomic) IBOutlet UILabel *rateNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;

@end
@implementation MovieDescriptionTableViewCell

NSString* const descriptionReuseIdentifier = @"movieDescriptionCell";
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


-(void)setUpDescriptionCellWithCrew:(NSArray*)crew withRate:(NSNumber*)rate withOverview:(NSString*)overview{
    self.overviewLabel.text = overview;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode: NSNumberFormatterRoundUp];
    self.rateNumberLabel.text = [formatter stringFromNumber:rate];
    
}

@end
