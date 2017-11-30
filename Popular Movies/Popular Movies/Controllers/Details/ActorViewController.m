//
//  ActorViewController.m
//  Popular Movies
//
//  Created by Test on 08/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "ActorCollectionView.h"
#import "ActorCollectionViewCell.h"
#import "ActorViewController.h"
#import "ActorService.h"
#import "Actor.h"
#import <RestKit/RestKit.h>
#import "CastMember.h"
#import "Gradient.h"
#import "ActorsMoviesTableViewCell.h"
#import "ActorDetailsTableViewCell.h"

@interface ActorViewController ()
{
    ActorService* actorService;
    Actor* selectedActor;
    BOOL isExpanded;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ActorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled = YES;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ActorDetailsTableViewCell class]) bundle:nil] forCellReuseIdentifier: actorsDetailsReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ActorsMoviesTableViewCell class]) bundle:nil] forCellReuseIdentifier: ActorsMoviesReusableIdentifier];
    selectedActor = [[Actor alloc]init];
    actorService = [[ActorService alloc]init];
    [self loadActorDetails];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 150;
    
    isExpanded = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Table view handling

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        ActorDetailsTableViewCell* cell1 = (ActorDetailsTableViewCell* )[tableView dequeueReusableCellWithIdentifier:actorsDetailsReuseIdentifier forIndexPath:indexPath];
        cell1 = [cell1 setUpActorsDetailsCellWithActorsName:selectedActor.name withProfilePath:selectedActor.profilePath withBirthday:selectedActor.birthday withBirthPlace:selectedActor.placeOfBirth withBiography:selectedActor.biography isExpended:isExpanded];
        cell1.delegate = self;
        return cell1;
    }
    ActorsMoviesTableViewCell* cell2 = (ActorsMoviesTableViewCell* )[tableView dequeueReusableCellWithIdentifier:ActorsMoviesReusableIdentifier forIndexPath:indexPath];
    cell2 = [cell2 setUpActorsMoviesCollectionViewCellWithDelegate:self withDataSource:self];
    return cell2;

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}
#pragma mark - Fetching actor's data

-(void)loadActorDetails{
    [actorService getActorInformation:self.actorId onSuccess:^(NSObject* object){
        selectedActor = [(RKMappingResult*)object firstObject];
        [self.tableView reloadData];
    } onError:^(NSError* error){
        NSLog(@"An error has occured while getting the actor's data from API");
    }];
}

#pragma mark - Actors movies collection view

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return selectedActor.movieCredits.cast.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ActorCollectionViewCell* cell = (ActorCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:actorReuseIdentifier forIndexPath:indexPath];
    cell = [cell setUpActorCellWithPosterPath:[[selectedActor.movieCredits.cast objectAtIndex:indexPath.row] posterPath] withFirstTitle:[[selectedActor.movieCredits.cast objectAtIndex:indexPath.row] title] withSecondTitle:[[selectedActor.movieCredits.cast objectAtIndex:indexPath.row] character]];
    cell.backgroundColor = collectionView.backgroundColor;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(collectionView.frame.size.width/4.2 , collectionView.frame.size.height );
}

#pragma mark - ActorDetailsTableViewCellDelegate delegate methods

-(void)readMoreClick:(UIButton *)sender{
     NSLog(@"some2");
    isExpanded = !isExpanded;
    if(sender.tag == 1){
        [sender setTitle:@"Hide" forState:UIControlStateNormal];
    }
    else{
        [sender setTitle:@"Read more" forState:UIControlStateNormal];
    }
    [self.tableView reloadData];
}
@end
