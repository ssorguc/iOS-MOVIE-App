//
//  TrailerViewController.h
//  Popular Movies
//
//  Created by Test on 28/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trailer.h"
@interface TrailerViewController : UIViewController
@property (nonatomic,strong)Trailer *selectedMovieTrailer;
@property (nonatomic,strong)NSString* movieDescription;
@end
