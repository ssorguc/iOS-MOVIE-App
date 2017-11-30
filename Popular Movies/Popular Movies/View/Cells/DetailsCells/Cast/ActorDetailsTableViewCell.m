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
@property (weak, nonatomic) IBOutlet UIButton *readMoreButton;

@end

NSString* const actorsDetailsReuseIdentifier =@"actorDetailsCell";

@implementation ActorDetailsTableViewCell

CGFloat maxBiographyLabelHeight = 175.0;

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Setting up cell's properties

-(ActorDetailsTableViewCell*)setUpActorsDetailsCellWithActorsName:(NSString*)name withProfilePath:(NSString*)profilePath withBirthday:(NSDate*)birthday withBirthPlace:(NSString*)place withBiography:(NSString*)biography isExpended:(BOOL)isExpended {
    
    //Setting up the name property of the actor
    self.actorsNameLabel.text = name;
    
    //Setting up the image property of the actor if the image exists
    if(profilePath){
        NSString* imageLink = [@"http://image.tmdb.org/t/p/w500/" stringByAppendingString: profilePath];
        [self.actorProfileImageView sd_setImageWithURL:[NSURL URLWithString: imageLink] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    self.actorProfileImageView.clipsToBounds = YES;
    
    //Setting up the birthday date and place of birth property of the actor
    NSString *datePlace;
    if(birthday){
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"d MMMM yyyy"];
        datePlace = [[df stringFromDate:birthday]stringByAppendingString:@" "];
        self.actorBirthdayLabel.text = datePlace;
    }
    if(place){
        datePlace = [datePlace stringByAppendingString:place];
        self.actorBirthdayLabel.text = datePlace;
    }
    
    //Setting up the biography property of the actor
    self.biographyLabel.text = biography;
    self.biographyLabel.numberOfLines = 0;
    [self.biographyLabel sizeToFit];
    if (!isExpended && CGRectGetHeight(self.biographyLabel.bounds) > maxBiographyLabelHeight) {
        self.biographyLabel.numberOfLines = 8;
        self.biographyLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.readMoreButton.tag = 1;
    } else {
        self.biographyLabel.numberOfLines = 0;
        self.biographyLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.readMoreButton.tag = 2;
    }
    [self.readMoreButton addTarget:self action:@selector(readMoreReview) forControlEvents:UIControlEventTouchUpInside];
    return self;
}
#pragma mark - Setting up the gradiend for the picture

-(void)layoutSubviews {
    [super layoutSubviews];
    
    if (_bottomBox == nil) {
        _bottomBox = [Gradient setUpActorsGradient];
        [self.actorProfileImageView.layer addSublayer:_bottomBox];
    }
    _bottomBox.frame = self.actorProfileImageView.bounds;
}

-(void)readMoreReview{
    NSLog(@"some");
    if (self.delegate && [self.delegate respondsToSelector:@selector(readMoreClick                                                                     :)]) {
        [self.delegate readMoreClick:self.readMoreButton];
    }
}
@end
