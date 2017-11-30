//
//  TVShowViewController.m
//  Popular Movies
//
//  Created by Test on 30/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import <RestKit/RestKit.h>
#import "TVShowViewController.h"
#import "TVShowService.h"
#import "TVShow.h"
#import "TVShowDetailTableViewController.h"
#import "TVShowCollection.h"
#import "MovieTvShowCollectionViewCell.h"
#import "SearchViewController.h"
@interface TVShowViewController ()
{
    NSMutableArray *tvShowArray;
    TVShowService *tvShowService;
    TVShow *tvShowSample;
    NSInteger numberOfPages;
    UISearchBar *searchBar;
    TVShowCollection *collection;
    UIButton *popularButton;
    UIButton *nowPlayingButton;
    UIButton *topRatedButton;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filterViewHightConstraint;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *mainFilteringButton;
@property (weak, nonatomic) IBOutlet UIImageView *upDowbIconImageVIew;

@end

@implementation TVShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //White back button
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    backButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    //Search bar
    searchBar = [[UISearchBar alloc]init];
    [searchBar setText:@"Search"];
    [searchBar setBarStyle:UIBarStyleBlack];
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    
    //Side menu
    UIBarButtonItem *sideMenu = [[UIBarButtonItem alloc]init];
    UIImage *btnImage = [UIImage imageNamed:@"menu-icon.png"];
    [sideMenu setImage:btnImage];
    [sideMenu setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = sideMenu;
    
    //Registrating the custom collection view cell
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MovieTvShowCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:movieTVShowReuseIdentifier];
    
    
    tvShowService = [[TVShowService alloc]init];
    tvShowArray = [[NSMutableArray alloc]init];
    numberOfPages = 1;
    [self loadPopularTVShows];
    
    //Adding filter menu buttons
    [self addFilterButtons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Collection View data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return tvShowArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieTvShowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:movieTVShowReuseIdentifier forIndexPath:indexPath];
    tvShowSample = (TVShow*)[tvShowArray objectAtIndex:indexPath.row];
    [cell setUpMovieTvShowCollectionViewCellWithTitle:tvShowSample.name imageLink:tvShowSample.posterPath releaseDate:tvShowSample.firstAirDate rating:tvShowSample.voteAverage];
    return  cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/2.2, self.view.frame.size.height/2.6);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"tvShowDetailsSegue" sender:indexPath];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"tvShowDetailsSegue"]) {
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] lastObject];
        TVShowDetailTableViewController* tvshowTVC = [segue destinationViewController];
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
        backButtonItem.tintColor = [UIColor whiteColor];
        tvshowTVC.self.navigationItem.backBarButtonItem = backButtonItem;
        tvshowTVC.tvshowId = [[tvShowArray objectAtIndex:indexPath.row] tvShowId];
    }
}

#pragma mark - Fetching data from API methods

-(void)loadPopularTVShows{
    [tvShowService getPopularTVShowFromAPIWithPageNumber:numberOfPages onSuccess:^(NSObject* object){
        TVShowCollection *collection = [(RKMappingResult*)object firstObject];
        [tvShowArray addObjectsFromArray:[collection results]];
        numberOfPages=numberOfPages+1;
        [self.collectionView reloadData];
    } onError:^(NSError* error){
        
    }];
}

-(void)loadTopRatedTVShows{
    [tvShowService getTopRatedTVShowFromAPIWithPageNumber:numberOfPages onSuccess:^(NSObject* object){
        TVShowCollection *collection = [(RKMappingResult*)object firstObject];
        [tvShowArray addObjectsFromArray:[collection results]];
        numberOfPages=numberOfPages+1;
        [self.collectionView reloadData];
    } onError:^(NSError* error){
        
    }];
}


#pragma mark - Filtering

-(void)addFilterButtons{
    popularButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 40)];
    popularButton.tag = 1;
    [popularButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [popularButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self setFilteringButtonsProperties:popularButton buttonText:@" Popular"];
    [self.tvShowMainFilterView addSubview:popularButton];
    [popularButton addTarget:self action:@selector(filterMoviesClickByButtonTag:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *btnImage = [UIImage imageNamed:@"checked-icon.png"];
    [popularButton setImage:btnImage forState:UIControlStateNormal];
    
    nowPlayingButton = [[UIButton alloc]initWithFrame:CGRectMake(0,90,self.view.frame.size.width,40)];
    [nowPlayingButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self setFilteringButtonsProperties:nowPlayingButton buttonText:@" Top Rated"];
    [self.tvShowMainFilterView addSubview:nowPlayingButton];
    [nowPlayingButton addTarget:self action:@selector(filterMoviesClickByButtonTag:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainFilteringButton setTitle:@" Popular" forState:UIControlStateNormal];
    nowPlayingButton.tag = 2;
    [nowPlayingButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];

    
}


-(void)setFilteringButtonsProperties:(UIButton* )button buttonText:(NSString*) text{
    [button setTitle:text forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.font = [UIFont fontWithName:@"System Font Regular" size:15];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.backgroundColor = [UIColor colorWithRed:0.07 green:0.07 blue:0.07 alpha:1.0];
    button.layer.borderWidth = 0.7f;
    button.layer.borderColor = [UIColor colorWithRed:0.30 green:0.31 blue:0.31 alpha:0.6].CGColor;
}

- (IBAction)filterButtonClick:(id)sender {
    self.upDowbIconImageVIew.image = [UIImage imageNamed:@"back-icon.png"];
    if (self.filterViewHightConstraint.constant > 45.0) {
        self.filterViewHightConstraint.constant = 43.0f;
        self.upDowbIconImageVIew.image = [UIImage imageNamed:@"list-icon.png"];
    } else {
        self.filterViewHightConstraint.constant = 130.0f;
        self.upDowbIconImageVIew.image = [UIImage imageNamed:@"back-icon.png"];
    }
}


-(void)filterMoviesClickByButtonTag:(UIButton *)sender{
    [tvShowArray removeAllObjects];
    [self.collectionView reloadData];
    numberOfPages = 1;
    UIImage *btnImage = [UIImage imageNamed:@"checked-icon.png"];
    //Depending on buttons tag we have different layout of the filtering view
    switch (sender.tag) {
        case 1:
            [self.mainFilteringButton setTitle:@" Popular" forState:UIControlStateNormal];
            [sender setImage:btnImage forState:UIControlStateNormal];
            [nowPlayingButton setImage:nil forState:UIControlStateNormal];
            [nowPlayingButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
            [topRatedButton setImage:nil forState:UIControlStateNormal];
            [topRatedButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
            [popularButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
            [self loadPopularTVShows];
            break;
        case 2:
            [self.mainFilteringButton setTitle:@" Top Rated" forState:UIControlStateNormal];
            [sender setImage:btnImage forState:UIControlStateNormal];
            [popularButton setImage:nil forState:UIControlStateNormal];
            [topRatedButton setImage:nil forState:UIControlStateNormal];
            [nowPlayingButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
            [popularButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
            [topRatedButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
            [self loadTopRatedTVShows];
            break;
        
            
        default:
            break;
    }
}

#pragma mark - Scrolling

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentYoffset = scrollView.contentOffset.y;
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentYoffset;
    if(distanceFromBottom < height)
    {
        if([self.mainFilteringButton.titleLabel.text containsString:@"Popular"]){
            [self loadPopularTVShows];
        }
        else if([self.mainFilteringButton.titleLabel.text containsString:@"Top Rated"]){
            [self loadTopRatedTVShows];
        }
    }
}

#pragma mark - SearchBar delegate methods

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    SearchViewController *searchViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    searchBar.text = @"";
    navigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:navigationController animated:YES completion:nil];
    
    //[self performSegueWithIdentifier:@"searchSegue" sender:self];
    return YES;
}
@end
