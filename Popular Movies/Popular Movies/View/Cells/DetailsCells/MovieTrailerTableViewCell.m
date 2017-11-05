//
//  MovieTrailerTableViewCell.m
//  Popular Movies
//
//  Created by Test on 24/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "VideosCollection.h"
#import "Trailer.h"
#import "Genre.h"
#import "Gradient.h"
#import "MovieTrailerTableViewCell.h"
@interface MovieTrailerTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titelLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *genresLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet YTPlayerView *movieTrailerView;
@property (weak, nonatomic) CAGradientLayer *bottomBox;
@end

@implementation MovieTrailerTableViewCell
NSString * const movieTrailerCellReuseIdentifier = @"movieTrailerCell";
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)setUpTrailerCellWithTitle:(NSString*)title releaseDateString:(NSDate*)releaseDate genresString: (NSArray*)genres trailers:(VideosCollection*)trailers runtime:(NSNumber*)runtime withIndexPath:(NSIndexPath*)indexPath{
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    //Release date label
    [df setDateFormat:@"d MMMM yyyy"];
    self.releaseDateLabel.text = [df stringFromDate:releaseDate];
    //Movie title label
    [df setDateFormat:@"yyyy"];
    self.titelLabel.text = [[[[title uppercaseString] stringByAppendingString:@" ("] stringByAppendingString:[df stringFromDate:releaseDate]] stringByAppendingString:@")"];
    //Genres label
    NSMutableArray* genresTemp = [[NSMutableArray alloc]init];
    for (Genre* g in genres){
        [genresTemp addObject:g.name];
    }
    self.genresLabel.text = [genresTemp componentsJoinedByString:@", "];
    
    //Trailer video
    Trailer* t = [[Trailer alloc]init];
    if(trailers.videoResults.count!=0){
        t = [trailers.videoResults objectAtIndex:0];
        NSDictionary *playerVars = @{@"playsinline" : @1,};
        [self.movieTrailerView loadWithVideoId:t.key playerVars:playerVars];
    }
    
    NSInteger value = [runtime integerValue]/60;
    NSInteger value2 = [runtime integerValue]- value*60;
    if(runtime == 0)self.durationLabel.text = @"";
    else{
        self.durationLabel.text = [[[[NSString stringWithFormat:@"%lu",value]stringByAppendingString:@" h "]stringByAppendingString:[NSString stringWithFormat:@"%lu",value2]]stringByAppendingString:@" min"];
    }
    
}

@end
