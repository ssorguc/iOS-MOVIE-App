//
//  SearchViewController.m
//  Popular Movies
//
//  Created by Test on 28/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import <RestKit/RestKit.h>
#import "MoviesViewController.h"
#import "SearchViewController.h"
#import "SearchService.h"
#import "SearchResult.h"
#import "SearchResultTableViewCell.h"
#import "SearchResultsCollection.h"
#import "SearchResult.h"

@interface SearchViewController ()
{
    UISearchBar *searchBar;
    NSMutableArray *searchResult;
    SearchService *searchService;
    SearchResultsCollection *searchResultsCollection;
    NSInteger numberOfPages;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Search bar
    searchBar.text = @"";
    searchBar = [[UISearchBar alloc]init];
    [searchBar setBarStyle:UIBarStyleBlack];
    self.navigationItem.titleView = searchBar;
    searchBar.delegate = self;
    
    //Side menu
    UIBarButtonItem *sideMenu = [[UIBarButtonItem alloc]init];
    UIImage *btnImage = [UIImage imageNamed:@"menu-icon.png"];
    [sideMenu setImage:btnImage];
    [sideMenu setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = sideMenu;
    
    //Setting up the Cancel button
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"Cancel"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(cancelSearch:)];
    [cancelButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = cancelButton;
    
    searchService = [[SearchService alloc]init];
    searchResult = [[NSMutableArray alloc]init];
    searchResultsCollection = [[SearchResultsCollection alloc]init];
    
    //Registrating the custom cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SearchResultTableViewCell class]) bundle:nil] forCellReuseIdentifier:searchResultReuseIdentifier];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorColor = self.tableView.backgroundColor;
    numberOfPages = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return searchResult.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultTableViewCell *cell = (SearchResultTableViewCell*)[tableView dequeueReusableCellWithIdentifier:searchResultReuseIdentifier];
    cell.backgroundColor = self.tableView.backgroundColor;
    SearchResult *singleSearchResult = (SearchResult*)[searchResult objectAtIndex:indexPath.row];
    if([singleSearchResult.mediaType isEqualToString:@"movie"]){
        [cell setUpSearchResultCellWithTitle:singleSearchResult.title withDate:singleSearchResult.releaseDate withVoteAverage:singleSearchResult.voteAverage withPosterPath:singleSearchResult.posterPath];
    }
    else{
        [cell setUpSearchResultCellWithTitle:singleSearchResult.name withDate:singleSearchResult.firstAirDate withVoteAverage:singleSearchResult.voteAverage withPosterPath:singleSearchResult.posterPath];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}


#pragma mark - Search bar
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *str = [searchBar.text stringByReplacingCharactersInRange:range withString:text];
    NSLog(@"String:%@",str);
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"search %@",searchBar.text);
    numberOfPages = 1;
    [searchResult removeAllObjects];
    self.tableView.separatorColor = self.tableView.backgroundColor;
    [self.tableView reloadData];
    [self loadSearchResults];
}

-(void)loadSearchResults{
    [searchService searchMoviesAndTVShowsWithPage:numberOfPages withQueryString:searchBar.text onSuccess:^(NSObject *object){
        searchResultsCollection = [(RKMappingResult*)object firstObject];
        [searchResult addObjectsFromArray:[searchResultsCollection results]];
        numberOfPages=numberOfPages+1;
        if(searchResult.count != 0 )self.tableView.separatorColor = [UIColor colorWithRed:0.44 green:0.43 blue:0.43 alpha:0.7];
        [self.tableView reloadData];
    } onError:^(NSError *error){
        NSLog(@"An error has occured while searching");
    }];
}

#pragma mark - Scrolling

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentYoffset = scrollView.contentOffset.y;
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentYoffset;
    if(distanceFromBottom < height)
    {
        [self loadSearchResults];
    }
}

#pragma mark - Cancel Button

-(void)cancelSearch:(UIBarButtonItem*)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
