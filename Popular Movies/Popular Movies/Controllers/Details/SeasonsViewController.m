//
//  SeasonsViewController.m
//  Popular Movies
//
//  Created by Test on 30/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "SeasonsViewController.h"

@interface SeasonsViewController ()
@property (weak, nonatomic) IBOutlet UIView *seasonsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seasonsHightConstraint;

@end

@implementation SeasonsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSInteger value = [self.numberOfSeasons integerValue];
    NSInteger width = 10;
    for(NSInteger i=0; i<value;i++){
        width = width + 40 *(i+1);
        if(width>self.view.frame.size.width){
            UIButton* singleSeasonButton = [[UIButton alloc]initWithFrame:CGRectMake(40 + 40 *(i+1), 40, 40, 40)];
            singleSeasonButton.tag = 1;
            [singleSeasonButton setTitle:[NSString stringWithFormat:@"%ld",i+1] forState:UIControlStateNormal];
            [self.seasonsView addSubview:singleSeasonButton];
        }
        else{
            UIButton* singleSeasonButton = [[UIButton alloc]initWithFrame:CGRectMake(10 + 40 *(i+1), 40, 40, 40)];
            singleSeasonButton.tag = 1;
            [singleSeasonButton setTitle:[NSString stringWithFormat:@"%ld",i+1] forState:UIControlStateNormal];
            [self.seasonsView addSubview:singleSeasonButton];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
