//
//  MovieTvShowCollectionViewCell.h
//  Popular Movies
//
//  Created by Test on 16/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MovieTvShowCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
+(CAGradientLayer*)blackGradient;
extern NSString * const reuseIdentifier;
@end
