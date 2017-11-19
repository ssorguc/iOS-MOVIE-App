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
@interface MovieTrailerTableViewCell : UITableViewCell
extern NSString * const movieTrailerCellReuseIdentifier;
-(void)setUpTrailerCellWithTitle:(NSString*)title releaseDateString:(NSDate*)releaseDate genresString: (NSArray*)genres trailers:(VideosCollection*)trailers runtime:(NSNumber*)runtime withIndexPath:(NSIndexPath*)indexPath;
@end
