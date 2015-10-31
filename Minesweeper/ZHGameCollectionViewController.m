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
@property (weak, nonatomic) IBOutlet UILabel *roundsLabel;
@property (weak, nonatomic) IBOutlet UILabel *minesLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

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
    
    __weak typeof(self) welf = self;
    
    [self.board setCellExplodedBlock:^(ZHCell *cell) {
        [welf.board showBombs];
        [welf refreshUI];
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"BOOM!" message:@"You lose!" preferredStyle:UIAlertControllerStyleAlert];
        
        [ac addAction:[UIAlertAction actionWithTitle:@"Well obviously..." style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [welf.navigationController popToRootViewControllerAnimated:YES];
        }]];
        
        [welf presentViewController:ac animated:YES completion:NULL];
    }];
    
    [self.board setSecondElapsedBlock:^(NSUInteger seconds) {
        welf.timeLabel.text = [NSString stringWithFormat:@"Sec:%lu", (unsigned long)seconds];
    }];
    
    [self refreshUI];
}

-(void)refreshUI{
    [self.collectionView reloadData];
    self.roundsLabel.text = [NSString stringWithFormat:@"Rounds:%lu", (unsigned long)self.board.roundCount];
    self.minesLabel.text = [NSString stringWithFormat:@"Mines:%lu", (unsigned long)self.board.mineCount];
    self.timeLabel.text = [NSString stringWithFormat:@"Sec:%lu", (unsigned long)self.board.secondsCount];
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

- (IBAction)quitButtonTouchUpInside:(id)sender {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Quit?" message:@"You will lose any progress gained" preferredStyle:UIAlertControllerStyleAlert];
    
    [ac addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }]];
    
    [ac addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [self presentViewController:ac animated:YES completion:NULL];

}

- (IBAction)validateButtonTouchUpInside:(id)sender {
    if([self.board validate] == YES){
        NSLog(@"Validated!");
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"You Win!" message:@"All mines discovered!" preferredStyle:UIAlertControllerStyleAlert];
        
        [ac addAction:[UIAlertAction actionWithTitle:@"Woohoo!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }]];
        
        [self presentViewController:ac animated:YES completion:NULL];
    } else {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"You've got work to do..." message:@"Keep trying!" preferredStyle:UIAlertControllerStyleAlert];
        
        [ac addAction:[UIAlertAction actionWithTitle:@"I will!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [self presentViewController:ac animated:YES completion:NULL];
    }
}

- (IBAction)cheatButtonTouchUpInside:(id)sender {
    [self.board cheat];
    [self refreshUI];
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
    ZHCell *cell = [self.board cellForIndexPath:indexPath];
    if(cell.isPlayed == NO){
        self.board.roundCount++;
        [self.board exposeCell:cell];
        [self refreshUI];
    }
    
}

@end
