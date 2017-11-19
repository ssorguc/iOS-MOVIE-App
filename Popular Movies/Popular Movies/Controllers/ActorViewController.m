//
//  ActorViewController.m
//  Popular Movies
//
//  Created by Test on 08/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import <SDWebImage/UIImageView+WebCache.h>
#import "ActorViewController.h"
#import "ActorService.h"
#import "Actor.h"
#import <RestKit/RestKit.h>
#import "Gradient.h"
@interface ActorViewController ()
{
    ActorService* actorService;
    Actor* selectedActor;
}
@property (weak, nonatomic) IBOutlet UILabel *biographyLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *actorImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) CAGradientLayer *bottomBox;
@end

@implementation ActorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    selectedActor = [[Actor alloc]init];
    actorService = [[ActorService alloc]init];
    [self loadActorDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)loadActorDetails{
    [actorService getActorInformation:self.actorId onSuccess:^(NSObject* object){
        selectedActor = [(RKMappingResult*)object firstObject];
        self.nameLabel.text = selectedActor.name;
        self.biographyLabel.text = selectedActor.biography;
        NSString* imageLink = [@"http://image.tmdb.org/t/p/original/" stringByAppendingString: selectedActor.profilePath];
        [self.actorImageView sd_setImageWithURL:[NSURL URLWithString: imageLink] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        if (_bottomBox == nil) {
            _bottomBox = [Gradient setUpGradient];
            [self.actorImageView.layer addSublayer:_bottomBox];
        }
        _bottomBox.frame = self.actorImageView.bounds;
    } onError:^(NSError* error){
        
    }];
}
@end
