//
//  TrailerViewController.m
//  Popular Movies
//
//  Created by Test on 28/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "TrailerViewController.h"
#import "YTPlayerView.h"

@interface TrailerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet YTPlayerView *trailerView;
@end

@implementation TrailerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary *playerVars = @{@"playsinline" : @1,};
    [self.trailerView loadWithVideoId:self.selectedMovieTrailer.key playerVars:playerVars];
    self.descriptionLabel.text = self.movieDescription;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
