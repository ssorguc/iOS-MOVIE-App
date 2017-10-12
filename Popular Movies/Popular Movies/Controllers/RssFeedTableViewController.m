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
    NSMutableArray * lista_vijesti;
    
}
@end

@implementation RssFeedTableViewController
NSString *const newsCellIdentifier = @"newsCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    //registrating the custom table view
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([NewsTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([NewsTableViewCell class])];
    //this part of the code needs to be replaced with populating the table view with API data
    lista_vijesti = [[NSMutableArray alloc]init];
    News * news1 = [[News alloc] init];
    news1.title = @"Music For Self Improvment";
    news1.source_link = @"www.source.com";
    news1.text = @"When I was just starting 6th grade I got my first job. Paperboy! Boy, was I excited. At that time I had spent a lot of time actually playing the video game Paperboy, so I knew I had what it took to get the job done. But, its just not that easy.";
    [lista_vijesti addObject:news1];
    [lista_vijesti addObject:news1];
    [lista_vijesti addObject:news1];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return lista_vijesti.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = (NewsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NewsTableViewCell class]) forIndexPath:indexPath];
  /*  if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"newsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }*/
    News * newsSample = (News*)[lista_vijesti objectAtIndex:indexPath.row];
    cell.titleLabel.text = newsSample.title;
    cell.linkLabel.text = newsSample.source_link;
    cell.contentTextBox.text = newsSample.text;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200.0f;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
