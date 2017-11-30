//
//  NewsTableViewCell.m
//  Popular Movies
//
//  Created by Test on 11/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "News.h"
@interface NewsTableViewCell(){
    NSString* sourceLink;
}
@property (weak, nonatomic) IBOutlet UIButton *linkButton;
@property (weak, nonatomic) IBOutlet UIView *backgroundBox;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsTitleLabel;
@end

@implementation NewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _backgroundBox.layer.cornerRadius=4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
-(void)setUpNewsCellWithNews:(News*)newsSample{
    sourceLink = newsSample.sourceLink;
    self.contentLabel.text = newsSample.text;
    self.newsTitleLabel.text = newsSample.title;
    [self.linkButton setTitle:newsSample.sourceLink forState:UIControlStateNormal];
}
- (IBAction)openSourceLink:(UIButton *)sender {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:[sourceLink substringToIndex:[sourceLink length]-2]];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];
}
@end
