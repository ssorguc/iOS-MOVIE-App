//
//  RssFeedTableViewController.m
//  Popular Movies
//
//  Created by Test on 10/3/17.
//  Copyright © 2017 Test. All rights reserved.
//

#import "RssFeedTableViewController.h"
#import "News.h"
#import "NewsTableViewCell.h"
@interface RssFeedTableViewController ()
{
    NSMutableArray* newsArray;
    NSXMLParser* newsParser;
    News* singleArticle;
    NSString* currentElement;
    NSMutableString* newsTitle;
    NSMutableString* newsText;
    NSMutableString* newsSource;
    IBOutlet UITableView *newsTableView;
}
@end

@implementation RssFeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.userInteractionEnabled = YES;
    newsTableView.scrollEnabled = YES;
    
    //Registrating the custom table view with reuse identifier
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([NewsTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([NewsTableViewCell class])];
    
    [self loadNews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = (NewsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NewsTableViewCell class]) forIndexPath:indexPath];
    News * newsSample = (News*)[newsArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = newsSample.title;
    cell.linkLabel.text = newsSample.source_link;
    cell.descriptionLabel.text = newsSample.text;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200.0f;
}

-(void)parser:(NSXMLParser *)parser {
}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    currentElement = elementName;
    if ([currentElement isEqualToString:@"item"]) {
        //Started parsing the element, so initialize single news article, and variables where we are going to store current title,text and link
        singleArticle = [[News alloc]init];
        newsTitle = [[NSMutableString alloc]init];
        newsText = [[NSMutableString alloc]init];
        newsSource = [[NSMutableString alloc]init];
    }
}
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    // When the parsing has been finished then simply reload the table view.
    [self.tableView reloadData];
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    //If we read 'item' that means we are at the end of xml element so we can store single news in the array
    if ([elementName isEqualToString:@"item"]) {
        singleArticle.text = newsText;
        singleArticle.title = newsTitle;
        singleArticle.source_link = newsSource;
        [newsArray addObject:singleArticle];
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
{
    // Depending on what we need from xml, save different strings that will be added as atributes of single news
    if([currentElement isEqualToString:@"title"]){
        [newsTitle appendString:string];
    }
    else if ([currentElement isEqualToString:@"link"]){
        [newsSource appendString:string];
    }
    else if([currentElement isEqualToString:@"description"]){
        [newsText appendString:string];
    }
}

-(void)loadNews{
    newsArray = [[NSMutableArray alloc]init];
    newsParser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://www.boxofficemojo.com/data/rss.php?file=topstories.xml"]];
    [newsParser setDelegate:self];
    [newsParser parse];
    if (newsArray.count != 0) {
        [self.tableView reloadData];
    }
}
@end
