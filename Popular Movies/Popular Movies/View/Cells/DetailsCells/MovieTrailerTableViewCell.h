//
//  MovieTrailerTableViewCell.h
//  Popular Movies
//
//  Created by Test on 24/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"
@interface MovieTrailerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet YTPlayerView *movieTrailerPlayer;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UIView *randomBox;
extern NSString * const movieTrailerCellReuseIdentifier;
@end
