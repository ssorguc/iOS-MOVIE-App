//
//  MovieTrailerTableViewCell.h
//  Popular Movies
//
//  Created by Test on 24/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "VideosCollection.h"
#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@protocol MovieTrailerTableViewCellDelegate <NSObject>

- (void)playVideo;

@end

extern NSString * const movieTrailerCellReuseIdentifier;

@interface MovieTrailerTableViewCell : UITableViewCell

@property (nonatomic, strong) id<MovieTrailerTableViewCellDelegate> delegate;

-(MovieTrailerTableViewCell*)setUpTrailerCellWithTitle:(NSString*)title releaseDateString:(NSDate*)releaseDate genresString: (NSArray*)genres trailers:(VideosCollection*)trailers runtime:(NSNumber*)runtime withIndexPath:(NSIndexPath*)indexPath withBackdropPath:(NSString*)backdropPath;

@end
