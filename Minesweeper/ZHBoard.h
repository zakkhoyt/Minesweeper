//
//  ZHBoard.h
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/29/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHCell.h"

@interface ZHBoard : NSObject



// The x and y size of the board
@property (nonatomic) CGSize size;
@property (nonatomic) NSUInteger mineCount;



- (instancetype)initWithSize:(CGSize)size mineCount:(NSUInteger)mineCount;
- (void)exposeCell:(ZHCell*)cell;



@end
