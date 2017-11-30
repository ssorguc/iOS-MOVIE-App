//
//  SingleImageViewController.m
//  Popular Movies
//
//  Created by Test on 29/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "SingleImageViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SingleImageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backdropImageView;

@end

@implementation SingleImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.backdropPath){
        NSString* imageLink = [@"http://image.tmdb.org/t/p/w500/" stringByAppendingString: self.backdropPath];
        [self.backdropImageView sd_setImageWithURL:[NSURL URLWithString: imageLink] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
