//
//  ImageGalleryTableViewCell.m
//  Popular Movies
//
//  Created by Test on 25/10/2017.
//  Copyright © 2017 Test. All rights reserved.
//
#import "SingleImageCollectionViewCell.h"
#import "ImageGalleryTableViewCell.h"
@interface ImageGalleryTableViewCell()
@property (weak, nonatomic) IBOutlet UICollectionView *imagesCollectionView;

@end
@implementation ImageGalleryTableViewCell
NSString* const imageGalleryReuseIdentifier = @"imageGalleryCell";
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)setUpImagesGalleryCellWithImagesCollection:(ImagesCollection*)imagesCollection withDelegate:(id)delegate withDataSource:(id)dataSource{
    self.imagesCollectionView.delegate = delegate;
    self.imagesCollectionView.dataSource = dataSource;
    [self.imagesCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SingleImageCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"imageCell"];
    [self.imagesCollectionView reloadData];
}
@end
