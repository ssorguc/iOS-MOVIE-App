//
//  TVShowDetailTableViewController.m
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import <SDWebImage/UIImageView+WebCache.h>
#import <RestKit/RestKit.h>
#import "ReviewTableViewCell.h"
#import "MovieTrailerTableViewCell.h"
#import "Genre.h"
#import "ImageGalleryTableViewCell.h"
#import "CastTableViewCell.h"
#import "MovieDescriptionTableViewCell.h"
#import "TVShowDetailTableViewController.h"
#import "SeasonsTableViewCell.h"
#import "SingleSeason.h"
#import "TVShow.h"
#import "TVShowService.h"
@interface TVShowDetailTableViewController (){
    TVShow* selectedTVShow;
    TVShowService* tvShowService;
}
@end

@implementation TVShowDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([MovieTrailerTableViewCell class]) bundle:nil] forCellReuseIdentifier:movieTrailerCellReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([ImageGalleryTableViewCell class]) bundle:nil] forCellReuseIdentifier:imageGalleryReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([MovieDescriptionTableViewCell class]) bundle:nil] forCellReuseIdentifier:descriptionReuseIdentifier];
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([CastTableViewCell class]) bundle:nil] forCellReuseIdentifier:castReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ReviewTableViewCell class]) bundle:nil] forCellReuseIdentifier:reviewReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SeasonsTableViewCell class]) bundle:nil] forCellReuseIdentifier:seasonsReuseIdentifier];
    tvShowService = [[TVShowService alloc]init];
    [tvShowService getTVShowDetailsFromAPIWithId:_tvshowId onSuccess:^(NSObject* object) {
        selectedTVShow = [(RKMappingResult*)object firstObject];
        [self.tableView reloadData];
    }onError:^(NSError* error){}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [[UITableViewCell alloc]init];
    if(indexPath.section == 0){
        MovieTrailerTableViewCell* cell1 = (MovieTrailerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:movieTrailerCellReuseIdentifier forIndexPath:indexPath];
        NSDateFormatter* df = [[NSDateFormatter alloc]init];
        
        //Release date
        [df setDateFormat:@"d MMMM yyyy"];
        cell1.releaseDateLabel.text = [df stringFromDate:selectedTVShow.firstAirDate];
        
        //Movie title
        [df setDateFormat:@"yyyy"];
        cell1.titleLabel.text = [[[[selectedTVShow.name uppercaseString] stringByAppendingString:@" ("] stringByAppendingString:[df stringFromDate:selectedTVShow.firstAirDate]] stringByAppendingString:@")"];
        
        //Genres
        NSMutableArray* genresTemp = [[NSMutableArray alloc]init];
        for (Genre* g in selectedTVShow.genres){
            [genresTemp addObject:g.name];
        }
        cell1.genreLabel.text = [genresTemp componentsJoinedByString:@", "];
        
        
        return cell1;
    }
    else if (indexPath.section == 1){
        MovieDescriptionTableViewCell* cell2 = (MovieDescriptionTableViewCell*)[tableView dequeueReusableCellWithIdentifier:descriptionReuseIdentifier forIndexPath:indexPath];
        cell2.descriptionLabel.text = selectedTVShow.overview;
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:2];
        [formatter setRoundingMode: NSNumberFormatterRoundUp];
        cell2.rateLabel.text = [formatter stringFromNumber:selectedTVShow.voteAverage];
        return cell2;
    }
    else if (indexPath.section == 2){
        SeasonsTableViewCell* cell3 = (SeasonsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:seasonsReuseIdentifier forIndexPath:indexPath];
        NSUInteger i=1;
        NSString* seasonsNum = [[NSString alloc]init];
        for(SingleSeason* s in selectedTVShow.seasons){
            seasonsNum = [seasonsNum stringByAppendingString:[NSString stringWithFormat:@"%lu",i]];
            seasonsNum = [seasonsNum stringByAppendingString:@" "];
            i=i+1;
        }
        cell3.seasonsNumLabel.text = seasonsNum;
        NSDateFormatter* df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"yyyy"];
        seasonsNum = @"";
        for(SingleSeason* s in selectedTVShow.seasons){
            seasonsNum = [seasonsNum stringByAppendingString:[df stringFromDate:s.airDate]];
            seasonsNum = [seasonsNum stringByAppendingString:@" "];
        }
        cell3.seasonsYearsLabel.text = seasonsNum;
        return cell3;
    }
    else if (indexPath.section == 3){
        ImageGalleryTableViewCell* cell4 = (ImageGalleryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:imageGalleryReuseIdentifier forIndexPath:indexPath];
        return cell4;
    }
    else if (indexPath.section == 4){
        CastTableViewCell* cell5 = (CastTableViewCell*)[tableView dequeueReusableCellWithIdentifier:castReuseIdentifier forIndexPath:indexPath];
        return cell5;
    }
    else if (indexPath.section == 5){
        ReviewTableViewCell* cell6 = (ReviewTableViewCell*)[tableView dequeueReusableCellWithIdentifier:reviewReuseIdentifier forIndexPath:indexPath];
        return cell6;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 390.0f;
}

@end
