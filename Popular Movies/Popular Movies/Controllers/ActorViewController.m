//
//  ActorViewController.m
//  Popular Movies
//
//  Created by Test on 08/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "ActorViewController.h"
#import "ActorService.h"
@interface ActorViewController ()
{
    ActorService* actorService;
    
}
@end

@implementation ActorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    actorService = [[ActorService alloc]init];
    [self loadActorDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)loadActorDetails{
    [actorService getActorInformation:self.actorId onSuccess:^(NSObject* object){
       // selectedMovie = [(RKMappingResult*)object firstObject];
    } onError:^(NSError* error){
        
    }];
}
@end
