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
}
@property (weak, nonatomic) IBOutlet UITableView *actorDetialsTableView;
@end

@implementation ActorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled = YES;
    [self.actorDetialsTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ActorDetailsTableViewCell class]) bundle:nil] forCellReuseIdentifier: actorsDetailsReuseIdentifier];
    [self.actorDetialsTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ActorsMoviesTableViewCell class]) bundle:nil] forCellReuseIdentifier: ActorsMoviesReusableIdentifier];
    selectedActor = [[Actor alloc]init];
    actorService = [[ActorService alloc]init];
    [self loadActorDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        ActorDetailsTableViewCell* cell1 = (ActorDetailsTableViewCell* )[tableView dequeueReusableCellWithIdentifier:actorsDetailsReuseIdentifier forIndexPath:indexPath];
        cell1 = [cell1 setUpActorsDetailsCellWithActorsName:selectedActor.name withProfilePath:selectedActor.profilePath withBirthday:selectedActor.birthday withBirthPlace:selectedActor.placeOfBirth withBiography:selectedActor.biography];
        return cell1;
    }
    ActorsMoviesTableViewCell* cell2 = (ActorsMoviesTableViewCell* )[tableView dequeueReusableCellWithIdentifier:ActorsMoviesReusableIdentifier forIndexPath:indexPath];
    cell2 = [cell2 setUpActorsMoviesCollectionViewCellWithDelegate:self withDataSource:self];
    return cell2;

}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0){
        static ActorDetailsTableViewCell* cell1 = nil;
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            cell1 = [tableView dequeueReusableCellWithIdentifier:actorsDetailsReuseIdentifier];
        });
        
        return [self calculateHeightForConfiguredSizingCell:cell1];
    }
    static ActorsMoviesTableViewCell* cell = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        cell = [tableView dequeueReusableCellWithIdentifier:ActorsMoviesReusableIdentifier];
        cell = [cell setUpActorsMoviesCollectionViewCellWithDelegate:self withDataSource:self];
    });
    
    return [self calculateHeightForConfiguredSizingCell:cell];
}
- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell layoutIfNeeded];
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}

-(void)loadActorDetails{
    [actorService getActorInformation:self.actorId onSuccess:^(NSObject* object){
        selectedActor = [(RKMappingResult*)object firstObject];
        [self.actorDetialsTableView reloadData];
    } onError:^(NSError* error){
        NSLog(@"An error has occured while getting the actor's data from API");
    }];
}
#pragma actors movies collection view
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
    
    return CGSizeMake(collectionView.frame.size.width/2.2 - 50, collectionView.frame.size.height );
}
@end
