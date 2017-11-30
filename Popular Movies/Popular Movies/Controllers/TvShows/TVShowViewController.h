//
//  TVShowViewController.h
//  Popular Movies
//
//  Created by Test on 30/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVShowViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UIView *tvShowMainFilterView;

@end
