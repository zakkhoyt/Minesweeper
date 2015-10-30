//
//  ZHGameCollectionViewController.m
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/30/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import "ZHGameCollectionViewController.h"
#import "ZHBoard.h"
#import "ZHCellCollectionViewCell.h"

@interface ZHGameCollectionViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@interface ZHGameCollectionViewController (UICollectionViewDataSource) <UICollectionViewDataSource>
@end

@interface ZHGameCollectionViewController (UICollectionViewDelegateFlowLayout) <UICollectionViewDelegateFlowLayout>
@end

@interface ZHGameCollectionViewController (UICollectionViewDelegate) <UICollectionViewDelegate>
@end

@implementation ZHGameCollectionViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.collectionView reloadData];
}


@end

@implementation ZHGameCollectionViewController (UICollectionViewDataSource)

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.board.size.width * self.board.size.height;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZHCellCollectionViewCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:@"ZHCellCollectionViewCell" forIndexPath:indexPath];
    cell.cell = [self.board cellForIndexPath:indexPath];
    return cell;
}

#pragma mark IBActions

- (IBAction)endBarButtonAction:(id)sender {
    [_board end];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end



@implementation ZHGameCollectionViewController (UICollectionViewDelegateFlowLayout)
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = collectionView.bounds.size.width / self.board.size.width;
    CGFloat height = collectionView.bounds.size.height / self.board.size.height;
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)cv layout:(UICollectionViewLayout*)cvl insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0;
}


@end

@implementation ZHGameCollectionViewController (UICollectionViewDelegate)
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    ZHCellCollectionViewCell *cell  = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor orangeColor];
    ZHCell *cell = [self.board cellForIndexPath:indexPath];
    if(cell.isPlayed == NO){
        [self.board exposeCell:cell];
    }
    
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    NSLog(@"inspect");
}

@end
