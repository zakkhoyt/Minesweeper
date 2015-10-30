//
//  ZHCellCollectionViewCell.m
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/30/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import "ZHCellCollectionViewCell.h"
#import "ZHCell.h"

@interface ZHCellCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *adjacentBombCountLabel;

@end

@implementation ZHCellCollectionViewCell

-(void)setCell:(ZHCell *)cell{
    _cell = cell;
    if(cell.isPlayed == YES){
        self.backgroundColor = [UIColor cyanColor];
        self.adjacentBombCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)cell.adjacentBombCount];
    } else {
        self.adjacentBombCountLabel.text = @"";
        self.backgroundColor = [UIColor grayColor];
    }
    
    if(cell.isBomb == YES){
        self.backgroundColor = [UIColor redColor];
    }
    
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [UIColor blackColor].CGColor;
}

@end
