//
//  ZHBoard.h
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/29/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHCell.h"

typedef void (^ZHBoardCellEmptyBlock)();
typedef void (^ZHBoardCellExplodedBlock)(ZHCell *cell);
typedef void (^ZHBoardSecondElapsedBlock)(NSUInteger seconds);


@interface ZHBoard : NSObject

// The x and y size of the board
@property (nonatomic) CGSize size;

// The number of mines on the board
@property (nonatomic) NSUInteger mineCount;

// Show or hide grid
@property (nonatomic) BOOL grid;

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

// Called when a user taps on a cell (process on background queue). Completion block is called on main queue.
- (void)playCell:(ZHCell*)cell completionBlock:(ZHBoardCellEmptyBlock)completionBlock;

// Validate the game progress
- (BOOL)validate;

// Use a cheat
- (void)cheat;

// Number of times user has cheated
- (NSUInteger)cheatCount;

// Set all bomb cells to visible
- (void)showBombs;

// Retrieve individual cells.
- (ZHCell*)cellForKey:(NSString*)key;
- (ZHCell*)cellForIndexPath:(NSIndexPath*)indexPath;

@end
