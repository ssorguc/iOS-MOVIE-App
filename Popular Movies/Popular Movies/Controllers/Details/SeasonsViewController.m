//
//  SeasonsViewController.m
//  Popular Movies
//
//  Created by Test on 30/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "SeasonsViewController.h"

@interface SeasonsViewController (){
    UIButton* singleSeasonButton;
}
@property (weak, nonatomic) IBOutlet UIView *seasonsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seasonsHightConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SeasonsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.tableView.delegate = self;
    self.tableView.separatorColor = [UIColor clearColor];
    NSInteger value = [self.numberOfSeasons integerValue];
    NSInteger width = 10;
    for(NSInteger i=0; i<value;i++){
        width = width + 40 *(i+1);
        singleSeasonButton = [[UIButton alloc]initWithFrame:CGRectMake(10 + 40 *(i+1), 40, 40, 40)];
        singleSeasonButton.tag = i;
        [singleSeasonButton setTitle:[NSString stringWithFormat:@"%ld",i+1] forState:UIControlStateNormal];
        [self.seasonsView addSubview:singleSeasonButton];
        [singleSeasonButton addTarget:self action:@selector(loadSeasonsEpisodes:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)loadSeasonsEpisodes:(UIButton*)sender{
    
}
@end
