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
@end

@implementation ZHCellCollectionViewCell

-(void)setCell:(ZHCell *)cell{
    _cell = cell;
    if(cell.isPlayed == YES){
        self.backgroundColor = [UIColor zhPlayedColor];
        if(cell.adjacentBombCount == 0){
            self.adjacentBombCountLabel.text = @"";
        } else {
            self.adjacentBombCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)cell.adjacentBombCount];
        }
    } else {
        self.adjacentBombCountLabel.text = @"";
        self.backgroundColor = [UIColor zhUnplayedColor];
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [UIColor zhGridColor].CGColor;
    }
    
    self.mineImageView.hidden = YES;
    if(cell.isBomb == YES && cell.bombVisible){
        self.backgroundColor = [UIColor zhMineColor];
        self.mineImageView.hidden = NO;
    }
}

@end
