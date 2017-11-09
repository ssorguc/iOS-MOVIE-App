//
//  TrailerViewController.m
//  Popular Movies
//
//  Created by Test on 05/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "MovieService.h"
#import "TrailerViewController.h"
#import "VideosCollection.h"
#import <RestKit/RestKit.h>
#import "YTPlayerView.h"
#import "Trailer.h"
@interface TrailerViewController ()
{
    MovieService* movieService;
    VideosCollection* videos;
}
@property (weak, nonatomic) IBOutlet YTPlayerView *movieTrailerview;
@end

@implementation TrailerViewController

- (void)viewDidLoad {
    self.movieTrailerview.userInteractionEnabled = YES;
    [movieService getMovieTrailerFromAPIWithId:self.movieID onSuccess:^(NSObject* object){
        videos = [(RKMappingResult*)object firstObject];
        [self viewDidLoad];
    } onError:^(NSError* error){
        NSLog(@"There's been an error with requestiong data from API.");
    }
     ];
    Trailer* t = [[Trailer alloc]init];
    if(videos.videoResults.count!=0){
        t = [videos.videoResults objectAtIndex:0];
        NSDictionary *playerVars = @{@"playsinline" : @1,};
        [self.movieTrailerview loadWithVideoId:t.key playerVars:playerVars];
    }
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
