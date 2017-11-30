//
//  MovieTrailerTableViewCell.m
//  Popular Movies
//
//  Created by Test on 24/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "VideosCollection.h"
#import "Trailer.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Genre.h"
#import "Gradient.h"
#import "MovieTrailerTableViewCell.h"

@interface MovieTrailerTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *backdropImageView;
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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor yellowColor];
    self.movieTrailerView.backgroundColor = [UIColor blackColor];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


-(MovieTrailerTableViewCell*)setUpTrailerCellWithTitle:(NSString*)title releaseDateString:(NSDate*)releaseDate genresString: (NSArray*)genres trailers:(VideosCollection*)trailers runtime:(NSNumber*)runtime withIndexPath:(NSIndexPath*)indexPath withBackdropPath:(NSString*)backdropPath{
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
    if(backdropPath){
        //Setting up the image property of the actor
        NSString* imageLink = [@"http://image.tmdb.org/t/p/w500/" stringByAppendingString: backdropPath];
        [self.backdropImageView sd_setImageWithURL:[NSURL URLWithString: imageLink] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
   
    NSInteger value = [runtime integerValue]/60;
    NSInteger value2 = [runtime integerValue]- value*60;
    if(runtime == 0)self.durationLabel.text = @"";
    else{
        self.durationLabel.text = [[[[NSString stringWithFormat:@"%lu",value]stringByAppendingString:@" h "]stringByAppendingString:[NSString stringWithFormat:@"%lu",value2]]stringByAppendingString:@" min"];
    }
    
    UIView *tempView = [[UIView alloc] initWithFrame:self.movieTrailerView.bounds];
    tempView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *playVideoGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openVideo)];
    [tempView addGestureRecognizer:playVideoGesture];
    
    [self.movieTrailerView addSubview:tempView];
    return  self;
}

- (void)openVideo {
    if (self.delegate && [self.delegate respondsToSelector:@selector(playVideo)]) {
        [self.delegate performSelector:@selector(playVideo)];
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    if (_bottomBox == nil) {
        _bottomBox = [Gradient setUpGradient];
        [self.backdropImageView.layer addSublayer:_bottomBox];
    }
    _bottomBox.frame = self.backdropImageView.bounds;
}
@end
