//
//  SearchResultTableViewCell.h
//  Popular Movies
//
//  Created by Test on 24/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString* const searchResultReuseIdentifier;
@interface SearchResultTableViewCell : UITableViewCell
-(void)setUpSearchResultCellWithTitle:(NSString*)title withDate:(NSDate*)date withVoteAverage:(NSNumber*)voteAverage withPosterPath:(NSString*)posterPath;
@end
