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
@property (weak, nonatomic) IBOutlet UIButton *seeMoreButton;
@end
@implementation ImageGalleryTableViewCell
NSString* const imageGalleryReuseIdentifier = @"imageGalleryCell";
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)setUpImagesGalleryCellWithImagesCollection:(ImagesCollection*)imagesCollection withDelegate:(id)delegate withDataSource:(id)dataSource{
    self.imagesCollectionView.delegate = delegate;
    self.imagesCollectionView.dataSource = dataSource;
    [self.imagesCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SingleImageCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:singleImageReuseIdentifier];
    [self.imagesCollectionView reloadData];
    [self.seeMoreButton addTarget:self action:@selector(seeMoreClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)seeMoreClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(seeDetailGallery)]) {
        [self.delegate seeDetailGallery];
    }
}
@end
