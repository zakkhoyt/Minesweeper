//
//  ZHCellCollectionViewCell.m
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/30/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import "ZHCellCollectionViewCell.h"
#import "ZHCell.h"

@implementation ZHCellCollectionViewCell

-(void)setCell:(ZHCell *)cell{
    _cell = cell;
    if(cell.isBomb == YES){
        self.backgroundColor = [UIColor redColor];
    } else {
        self.backgroundColor = [UIColor cyanColor];
    }
    
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    
}
@end
