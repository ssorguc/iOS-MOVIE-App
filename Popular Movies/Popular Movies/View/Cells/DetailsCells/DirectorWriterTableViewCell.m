//
//  DirectorWriterTableViewCell.m
//  Popular Movies
//
//  Created by Test on 09/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "CrewMember.h"
#import "DirectorWriterTableViewCell.h"
@interface DirectorWriterTableViewCell(){
    NSString* allWriters;
    NSString* allDirectors;
}
@property (weak, nonatomic) IBOutlet UILabel *statisWriterLabel;
@property (weak, nonatomic) IBOutlet UILabel *allWritersLabel;
@property (weak, nonatomic) IBOutlet UILabel *allDirectorsLabel;
@end
@implementation DirectorWriterTableViewCell
NSString* const directorWriterReuseIdentifier = @"directorWriterCell";
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setUpDirectorsWritersCellWithCrew:(NSArray*)crew{
    [self getWritersDirectorsStringForLabelWithCastCollectionCrew:crew];
    self.allWritersLabel.text = allWriters;
    self.allDirectorsLabel.text = allDirectors;
    
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
