//
//  ZHBoard.h
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/29/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHCell.h"

typedef void (^ZHBoardCellExplodedBlock)(ZHCell *cell);
typedef void (^ZHBoardSecondElapsedBlock)(NSUInteger seconds);


@interface ZHBoard : NSObject

// The x and y size of the board
@property (nonatomic) CGSize size;

// The number of mines on the board
@property (nonatomic) NSUInteger mineCount;

// Number of rounds that have elapsed
@property (nonatomic) NSUInteger roundCount;

// Number of seconds that have elapsed
@property (nonatomic) NSUInteger secondsCount;

// Instantiate a new board with size and mine count
- (instancetype)initWithSize:(CGSize)size mineCount:(NSUInteger)mineCount;

// A callback block for when a cell explodes
- (void)setCellExplodedBlock:(ZHBoardCellExplodedBlock)cellExplodedBlock;

// A callback when the timer ticks
- (void)setSecondElapsedBlock:(ZHBoardSecondElapsedBlock)secondElapsedBlock;

// Called when a user taps on a cell
- (void)exposeCell:(ZHCell*)cell;

// Validate the game progress
- (BOOL)validate;

- (void)cheat;

- (void)showBombs;

// Retrieve individual cells.
- (ZHCell*)cellForKey:(NSString*)key;
- (ZHCell*)cellForIndexPath:(NSIndexPath*)indexPath;

@end
