//
//  SeasonsTableViewCell.m
//  Popular Movies
//
//  Created by Test on 26/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "SingleSeason.h"

#import "SeasonsTableViewCell.h"
@interface SeasonsTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *seasonNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *seasonsYearsLabel;

@end
@implementation SeasonsTableViewCell
NSString* const seasonsReuseIdentifier = @"seasonsCell";

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setUpSeasonsCellWithSeasons:(NSArray*)seasons  withNumberOfSeasons:(NSNumber*)numberOfSeasons{
    self.seasonNumLabel.text = [self getSeasonNumberStringWithNumberOfSeasons:numberOfSeasons];
    self.seasonsYearsLabel.text = [self getSeasonsYearsNumberWithSeasons:seasons];
    
}
-(NSString*)getSeasonNumberStringWithNumberOfSeasons:(NSNumber*)numberOfSeasons{
    NSString* seasonsString = @"";
    
    NSInteger i;
    for(i=1; i<=[numberOfSeasons integerValue];i++){
        seasonsString = [seasonsString stringByAppendingString:[NSString stringWithFormat:@"%lu",i]];
        seasonsString = [seasonsString stringByAppendingString:@" "];
    }
    return seasonsString;
}
-(NSString*)getSeasonsYearsNumberWithSeasons:(NSArray*)seasons{
    NSString* seasonYearsString = @"";
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy"];
    if(seasons){
        for(SingleSeason*  seasonItem in seasons){
            if(seasonItem.airDate!=nil){
                seasonYearsString = [seasonYearsString stringByAppendingString:[NSString stringWithFormat:@"%@",[df stringFromDate: seasonItem.airDate]]];
                seasonYearsString = [seasonYearsString stringByAppendingString:@" "];
            }
        }
    }
    return seasonYearsString;
}
@end
