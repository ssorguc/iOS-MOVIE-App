//
//  ActorDetailsTableViewCell.m
//  Popular Movies
//
//  Created by Test on 20/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "Gradient.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ActorDetailsTableViewCell.h"
@interface ActorDetailsTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *actorsNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *actorProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *actorBirthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *biographyLabel;
@property (weak, nonatomic) CAGradientLayer *bottomBox;
@end
@implementation ActorDetailsTableViewCell
NSString* const actorsDetailsReuseIdentifier =@"actorDetailsCell";
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(ActorDetailsTableViewCell*)setUpActorsDetailsCellWithActorsName:(NSString*)name withProfilePath:(NSString*)profilePath withBirthday:(NSDate*)birthday withBirthPlace:(NSString*)place withBiography:(NSString*)biography{
    //Setting up the name property of the actor
    self.actorsNameLabel.text = name;
    if(profilePath){
        //Setting up the image property of the actor
        NSString* imageLink = [@"http://image.tmdb.org/t/p/w342/" stringByAppendingString: profilePath];
        [self.actorProfileImageView sd_setImageWithURL:[NSURL URLWithString: imageLink] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    //Setting up the birthday date and place of birth property of the actor
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"d MMMM yyyy"];
    NSString* datePlace = [[[df stringFromDate:birthday]stringByAppendingString:@" "]stringByAppendingString:place];
    self.actorBirthdayLabel.text = datePlace;
    
    //Setting up the biography property of the actor
    self.biographyLabel.text = biography;
    
    return self;
}
-(void)layoutSubviews {
    [super layoutSubviews];
    
    if (_bottomBox == nil) {
        _bottomBox = [Gradient setUpActorsGradient];
        [self.actorProfileImageView.layer addSublayer:_bottomBox];
    }
    _bottomBox.frame = self.actorProfileImageView.bounds;
}
@end
