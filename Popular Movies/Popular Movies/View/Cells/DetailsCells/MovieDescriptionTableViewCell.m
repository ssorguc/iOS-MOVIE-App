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
@property (weak, nonatomic) IBOutlet UILabel *writersLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorsLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;

@end
@implementation MovieDescriptionTableViewCell

NSString* const descriptionReuseIdentifier = @"movieDescriptionCell";
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setUpDescriptionCellWithCrew:(NSArray*)crew withRate:(NSNumber*)rate withOverview:(NSString*)overview{
    self.overviewLabel.text = overview;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode: NSNumberFormatterRoundUp];
    self.rateNumberLabel.text = [formatter stringFromNumber:rate];
    [self getWritersDirectorsStringForLabelWithCastCollectionCrew:crew];
    self.writersLabel.text = allWriters;
    self.directorsLabel.text = allDirectors;
}

-(void)getWritersDirectorsStringForLabelWithCastCollectionCrew:(NSArray*)crew{
    allWriters = @"";
    allDirectors = @"";
    NSInteger i = 1;
    for(CrewMember* crewTemp in crew){
        if([crewTemp.job isEqualToString:@"Director"]){
            allDirectors = [allDirectors stringByAppendingString:crewTemp.name];
            allDirectors = [allDirectors stringByAppendingString:@", "];
            
        }
        if([crewTemp.job isEqualToString:@"Writer"]){
            allWriters = [allWriters stringByAppendingString:crewTemp.name];
            allWriters = [allWriters stringByAppendingString:@", "];
        }
        if(i == crew.count){
            if([allDirectors length]!=0 )allDirectors = [allDirectors substringToIndex:[allDirectors length]-2];
            if([allWriters length]!=0 )allWriters = [allWriters substringToIndex:[allWriters length]-2];
        }
        i=i+1;
    }
}
@end
