//
//  ActorsMoviesTableViewCell.h
//  Popular Movies
//
//  Created by Test on 21/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString* const ActorsMoviesReusableIdentifier;

@interface ActorsMoviesTableViewCell : UITableViewCell

-(ActorsMoviesTableViewCell*)setUpActorsMoviesCollectionViewCellWithDelegate:(id)delegate withDataSource:(id)dataSource;

@end
