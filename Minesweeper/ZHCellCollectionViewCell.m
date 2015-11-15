//
//  ZHCellCollectionViewCell.m
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/30/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import "ZHCellCollectionViewCell.h"
#import "ZHCell.h"
#import "UIColor+ZH.h"

@interface ZHCellCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *adjacentBombCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mineImageView;
@property (weak, nonatomic) IBOutlet UILabel *unplayedLabel;
@end

@implementation ZHCellCollectionViewCell

-(void)setCell:(ZHCell *)cell{
    _cell = cell;
    
    self.unplayedLabel.hidden = NO;
    self.unplayedLabel.textColor = [UIColor lightGrayColor];
    
    if(cell.isPlayed == YES){
        self.unplayedLabel.hidden = YES;
        self.backgroundColor = cell.isCheat ? [UIColor zhCheatColor] : [UIColor zhPlayedColor];
        if(cell.adjacentBombCount == 0){
            self.adjacentBombCountLabel.text = @"";
        } else {
            self.adjacentBombCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)cell.adjacentBombCount];
        }
    } else {
        self.adjacentBombCountLabel.text = @"";
        self.backgroundColor = [UIColor zhUnplayedColor];
        
//        self.layer.borderWidth = 1.0;
//        self.layer.borderColor = [UIColor zhGridColor].CGColor;
    }
    
    self.mineImageView.hidden = YES;
    if(cell.isBomb == YES && cell.bombVisible){
        self.backgroundColor = [UIColor zhMineColor];
        self.mineImageView.hidden = NO;
        self.unplayedLabel.hidden = YES;
    }
}

-(void)setFocused:(BOOL)focused{
    if(focused){
        self.unplayedLabel.textColor = [UIColor blackColor];
    } else {
        self.unplayedLabel.textColor = [UIColor lightGrayColor];\
    }
}
@end
