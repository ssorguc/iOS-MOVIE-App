//
//  MoviesViewController.h
//  Popular Movies
//
//  Created by Test on 19/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UIView *moviesFilterView;

@end
