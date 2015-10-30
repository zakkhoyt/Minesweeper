//
//  ZHGame.m
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/29/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import "ZHGame.h"
#import "ZHBoard.h"

@interface ZHGame ()
@property (nonatomic, strong) ZHBoard *board;
@end

@implementation ZHGame

- (instancetype)initWithSize:(CGSize)size mineCount:(NSUInteger)mineCount {
    self = [super init];
    if (self) {
        _board = [[ZHBoard alloc]initWithSize:size mineCount:mineCount];
        _size = size;
        _mineCount = mineCount;
    }
    return self;
}

- (void)end{
    NSLog(@"Game Ended.");
}

@end
