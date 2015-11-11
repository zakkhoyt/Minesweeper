//
//  ZHGameCollectionViewController.m
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/30/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import "ZHUIKitGameViewController.h"
#import "ZHBoard.h"
#import "ZHCellCollectionViewCell.h"

@interface ZHUIKitGameViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *roundsLabel;
@property (weak, nonatomic) IBOutlet UILabel *minesLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@interface ZHUIKitGameViewController (UICollectionViewDataSource) <UICollectionViewDataSource>
@end

@interface ZHUIKitGameViewController (UICollectionViewDelegateFlowLayout) <UICollectionViewDelegateFlowLayout>
@end

@interface ZHUIKitGameViewController (UICollectionViewDelegate) <UICollectionViewDelegate>
@end

@implementation ZHUIKitGameViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    __weak typeof(self) welf = self;
    
    [self.board setCellExplodedBlock:^(ZHCell *cell) {
        [welf.board showBombs];
        [welf refreshUI];
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"BOOM!" message:@"You lose!" preferredStyle:UIAlertControllerStyleAlert];
        
        [ac addAction:[UIAlertAction actionWithTitle:@"New Game" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [welf.navigationController popToRootViewControllerAnimated:YES];
        }]];
        
        [ac addAction:[UIAlertAction actionWithTitle:@"Stay and learn" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
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


#pragma mark IBActions

-(void)quit{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Quit?" message:@"You will lose any progress gained" preferredStyle:UIAlertControllerStyleAlert];
    
    [ac addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }]];
    
    [ac addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [self presentViewController:ac animated:YES completion:NULL];

}
- (IBAction)quitButtonTouchUpInside:(id)sender {
    [self quit];
}
- (IBAction)quitButtonPrimaryAction:(id)sender {
    [self quit];
}

-(void)validate{
    if([self.board validate] == YES){
        NSLog(@"Validated!");
        
        NSString *message = nil;
        if(self.board.cheatCount > 0){
            message = [NSString stringWithFormat:@"But not really because you cheated %lu times. All mines \"discovered\"!", (unsigned long)self.board.cheatCount];
        } else {
            message = @"All mines discovered!";
        }
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"You Win!" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        [ac addAction:[UIAlertAction actionWithTitle:@"New Game" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }]];
        
        [ac addAction:[UIAlertAction actionWithTitle:@"Stay and learn" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        
        [self presentViewController:ac animated:YES completion:NULL];
    } else {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"You've got work to do..." message:@"Keep trying!" preferredStyle:UIAlertControllerStyleAlert];
        
        [ac addAction:[UIAlertAction actionWithTitle:@"I will!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [self presentViewController:ac animated:YES completion:NULL];
    }
}
- (IBAction)validateButtonTouchUpInside:(id)sender {
    [self validate];
}
- (IBAction)validateButtonPrimaryAction:(id)sender {
    [self validate];
}

-(void)cheat{
    [self.board cheat];
    [self refreshUI];
}


- (IBAction)cheatButtonTouchUpInside:(id)sender {
    [self cheat];
}
#if defined(TARGET_OS_TV)
- (IBAction)cheatButtonPrimaryAction:(id)sender {
    [self cheat];
}
#endif


@end

@implementation ZHUIKitGameViewController (UICollectionViewDataSource)

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.board.size.width * self.board.size.height;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZHCellCollectionViewCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:@"ZHCellCollectionViewCell" forIndexPath:indexPath];
    cell.cell = [self.board cellForIndexPath:indexPath];
    return cell;
}

@end



@implementation ZHUIKitGameViewController (UICollectionViewDelegateFlowLayout)
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

@implementation ZHUIKitGameViewController (UICollectionViewDelegate)
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZHCell *cell = [self.board cellForIndexPath:indexPath];
    if(cell.isPlayed == NO){
        self.board.roundCount++;
//        [self.board exposeCell:cell];
        [self.board playCell:cell completionBlock:^{
            [self refreshUI];
        }];
        
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didUpdateFocusInContext:(UICollectionViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator{
    NSIndexPath *prevIndexPath = [context previouslyFocusedIndexPath];
    if (prevIndexPath) {
        ZHCellCollectionViewCell *cell = (ZHCellCollectionViewCell*)[collectionView cellForItemAtIndexPath:prevIndexPath];
        [cell setCell:cell.cell];
    }
    
    NSIndexPath *nextIndexPath = [context nextFocusedIndexPath];
    if (nextIndexPath) {
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:nextIndexPath];
        cell.backgroundColor = [UIColor greenColor];
    }
}

@end
