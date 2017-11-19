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
extern NSString * const movieTVShowReuseIdentifier;
-(void)setUpMovieTvShowCollectionViewCellWithTitle:(NSString*)title imageLink:(NSString*)posterPath releaseDate:(NSDate*)date rating:(NSNumber*)voteAverage;
@end
