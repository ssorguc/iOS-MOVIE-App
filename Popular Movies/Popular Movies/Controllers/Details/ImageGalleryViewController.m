//
//  ImageGalleryViewController.m
//  Popular Movies
//
//  Created by Test on 29/11/2017.
//  Copyright © 2017 Test. All rights reserved.
//

#import "ImageGalleryViewController.h"
#import "SingleImageViewController.h"
#import "SingleImageCollectionViewCell.h"
@interface ImageGalleryViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ImageGalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SingleImageCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:singleImageReuseIdentifier];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagesCollection.backdrops.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SingleImageCollectionViewCell *cell = (SingleImageCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:singleImageReuseIdentifier forIndexPath:indexPath];
    [cell setUpSingleImageCellWithSingleImage:[self.imagesCollection.backdrops objectAtIndex:indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(collectionView.frame.size.width/3.5 , collectionView.frame.size.height/5.2 );
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"singleImageSegue" sender:indexPath];
}
        
#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"singleImageSegue"] ){
        NSIndexPath* indexPath = (NSIndexPath*)sender;
        SingleImageViewController *singleImageViewController = [segue destinationViewController];
        singleImageViewController.backdropPath = [[self.imagesCollection.backdrops objectAtIndex:indexPath.row] filePath];
        [self setUpViewTitleLabelWithTitle:@"Image" withController:singleImageViewController];
    }
}
-(void)setUpViewTitleLabelWithTitle:(NSString*)title withController:(UIViewController*)controller{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero] ;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:17.0];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    controller.navigationItem.titleView = label;
}
@end
