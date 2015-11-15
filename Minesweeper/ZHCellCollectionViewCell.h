//
//  ZHCellCollectionViewCell.h
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/30/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHCell;

@interface ZHCellCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) ZHCell *cell;
-(void)setFocused:(BOOL)focused;
@end
