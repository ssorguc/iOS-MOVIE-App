//
//  MoviesViewController.m
//  Popular Movies
//
//  Created by Test on 19/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "SearchViewController.h"
#import "MoviesViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MovieService.h"
#import "MovieCollection.h"
#import "MovieTvShowCollectionViewCell.h"
#import "Movie.h"
#import "Genre.h"
#import "MovieDetailTableViewController.h"
#import <RestKit/RestKit.h>

@interface MoviesViewController ()
{
    UIButton *popularButton;
    UIButton *nowPlayingButton;
    UIButton *topRatedButton;
    NSMutableArray *moviesArray;
    MovieService *movieService;
    Movie *movieSample;
    NSInteger numberOfPages;
    UISearchBar *searchBar;
    MovieCollection *collection;
}

@property (weak, nonatomic) IBOutlet UIImageView *upDownFilterImage;
@property (weak, nonatomic) IBOutlet UIButton *mainFilteringButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filterViewHightConstraint;
@property (weak, nonatomic) IBOutlet UICollectionView *moviesCollectionView;

@end


@implementation MoviesViewController

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
    [self.moviesCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MovieTvShowCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:movieTVShowReuseIdentifier];
    movieService = [[MovieService alloc]init];
    moviesArray = [[NSMutableArray alloc]init];
    numberOfPages=1;
    
    //At start showing Popular movies
    [self loadPopularMovies];
    
    //Adding filter menu buttons
    [self addFilterButtons];
    
    
    
}


#pragma mark - Movie filtering buttons

- (IBAction)expandFiletViewAction:(id)sender {
    self.upDownFilterImage.image = [UIImage imageNamed:@"back-icon.png"];
    if (self.filterViewHightConstraint.constant > 45.0) {
        self.filterViewHightConstraint.constant = 43.0f;
        self.upDownFilterImage.image = [UIImage imageNamed:@"list-icon.png"];
    } else {
        self.filterViewHightConstraint.constant = 171.0f;
        self.upDownFilterImage.image = [UIImage imageNamed:@"back-icon.png"];
    }
}


-(void)addFilterButtons{
    popularButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 40)];
    popularButton.tag = 1;
    [popularButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [popularButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self setFilteringButtonsProperties:popularButton buttonText:@" Popular"];
    [self.moviesFilterView addSubview:popularButton];
    [popularButton addTarget:self action:@selector(filterMoviesClickByButtonTag:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *btnImage = [UIImage imageNamed:@"checked-icon.png"];
    [popularButton setImage:btnImage forState:UIControlStateNormal];
    
    nowPlayingButton = [[UIButton alloc]initWithFrame:CGRectMake(0,90,self.view.frame.size.width,40)];
    [nowPlayingButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self setFilteringButtonsProperties:nowPlayingButton buttonText:@" Now Playing"];
    [self.moviesFilterView addSubview:nowPlayingButton];
    [nowPlayingButton addTarget:self action:@selector(filterMoviesClickByButtonTag:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainFilteringButton setTitle:@"Popular" forState:UIControlStateNormal];
    nowPlayingButton.tag = 2;
    [nowPlayingButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    
    topRatedButton = [[UIButton alloc]initWithFrame:CGRectMake(0,130,self.view.frame.size.width,40)];
    [topRatedButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [self setFilteringButtonsProperties:topRatedButton buttonText:@" Top Rated"];
    [self.moviesFilterView addSubview:topRatedButton];
    [topRatedButton addTarget:self action:@selector(filterMoviesClickByButtonTag:) forControlEvents:UIControlEventTouchUpInside];
    topRatedButton.tag = 3;
    [topRatedButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];

}

-(void)filterMoviesClickByButtonTag:(UIButton *)sender{
    [moviesArray removeAllObjects];
    [self.moviesCollectionView reloadData];
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
            [self loadPopularMovies];
            break;
        case 2:
            [self.mainFilteringButton setTitle:@" Now Playing" forState:UIControlStateNormal];
            [sender setImage:btnImage forState:UIControlStateNormal];
            [popularButton setImage:nil forState:UIControlStateNormal];
            [topRatedButton setImage:nil forState:UIControlStateNormal];
            [nowPlayingButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
            [popularButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
            [topRatedButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
            [self loadNowPlayingMovies];
            break;
        case 3:
            [self.mainFilteringButton setTitle:@" Top Rated" forState:UIControlStateNormal];
            [sender setImage:btnImage forState:UIControlStateNormal];
            [popularButton setImage:nil forState:UIControlStateNormal];
            [nowPlayingButton setImage:nil forState:UIControlStateNormal];
            [topRatedButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
            [nowPlayingButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
            [popularButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
            [self loadTopRatedMovies];
            break;

        default:
            break;
    }
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Collection View data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return moviesArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieTvShowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:movieTVShowReuseIdentifier forIndexPath:indexPath];
    movieSample = [[Movie alloc]init];
    movieSample = (Movie*)[moviesArray objectAtIndex:indexPath.row];
    [cell setUpMovieTvShowCollectionViewCellWithTitle:movieSample.title imageLink:movieSample.posterPath releaseDate:movieSample.releaseDate rating:movieSample.voteAverage];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/2.2, self.view.frame.size.height/2.6);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"movieDetailSegue" sender:indexPath];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"movieDetailSegue"]) {
        NSIndexPath *indexPath = [[self.moviesCollectionView indexPathsForSelectedItems] lastObject];
        MovieDetailTableViewController* movieDetailTVC = [segue destinationViewController];
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
        backButtonItem.tintColor = [UIColor whiteColor];
        movieDetailTVC.self.navigationItem.backBarButtonItem = backButtonItem;
        movieDetailTVC.movieId = [[moviesArray objectAtIndex:indexPath.row] movieId];
    }
    
}

#pragma mark - Fetching Movie data from API methods

-(void)loadPopularMovies{
    [movieService gePopularMoviesFromAPIWithPage:numberOfPages onSuccess:^(NSObject* object){
        collection = [(RKMappingResult*)object firstObject];
        [moviesArray addObjectsFromArray:[collection results]];
        numberOfPages=numberOfPages+1;
        [self.moviesCollectionView reloadData];
    } onError:^(NSError* error){
        NSLog(@"An error has occured while fetching Popular movies data from Movie DataBase API.");
    }];
}
-(void)loadTopRatedMovies{
    [movieService getTopRatedMoviesFromAPIWithPage:numberOfPages onSuccess:^(NSObject *object){
        collection = [(RKMappingResult *)object firstObject];
        [moviesArray addObjectsFromArray:[collection results]];
        numberOfPages=numberOfPages+1;
        [self.moviesCollectionView reloadData];
    } onError:^(NSError *error){
        NSLog(@"An error has occured while fetching Top Rated movies data from Movie DataBase API.");
    }];
}
-(void)loadNowPlayingMovies{
    [movieService getNowPlayingMoviesFromAPIWithPage:numberOfPages onSuccess:^(NSObject *object){
        collection = [(RKMappingResult *)object firstObject];
        [moviesArray addObjectsFromArray:[collection results]];
        numberOfPages=numberOfPages+1;
        [self.moviesCollectionView reloadData];
    } onError:^(NSError *error){
        NSLog(@"An error has occured while fetching Now Playing movies data from Movie DataBase API.");
    } ];
}

#pragma mark - Scrolling

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentYoffset = scrollView.contentOffset.y;
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentYoffset;
    if(distanceFromBottom < height)
    {
        if([self.mainFilteringButton.titleLabel.text containsString:@"Popular"]){
            [self loadPopularMovies];
        }
        else if([self.mainFilteringButton.titleLabel.text containsString:@"Now Playing"]){
            [self loadNowPlayingMovies];
        }
        else if([self.mainFilteringButton.titleLabel.text containsString:@"Top Rated"]){
            [self loadTopRatedMovies];
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
