//
//  ActorCollectionViewCell.m
//  Popular Movies
//
//  Created by Test on 31/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import <SDWebImage/UIImageView+WebCache.h>
#import "ActorCollectionViewCell.h"
@interface ActorCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *actorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *characterNameLabel;

@end

@implementation ActorCollectionViewCell

NSString* const actorReuseIdentifier = @"actorCell";

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)setUpActorCellWithActor:(Actor *)singleActor{
    self.actorNameLabel.text = singleActor.name;
    self.characterNameLabel.text = singleActor.character;
    if(singleActor.profilePath){
        NSString* imageLink = [@"http://image.tmdb.org/t/p/w185/" stringByAppendingString: singleActor.profilePath];
        [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString: imageLink] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
}
-(ActorCollectionViewCell*)setUpActorCellWithPosterPath:(NSString *)posterPath withFirstTitle:(NSString*)firstTitle withSecondTitle:(NSString*)secondTitle{
    self.actorNameLabel.text = firstTitle;
    self.characterNameLabel.text = secondTitle;
    if(posterPath){
        NSString* imageLink = [@"http://image.tmdb.org/t/p/w185/" stringByAppendingString: posterPath];
        [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString: imageLink] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    return self;
}
@end
