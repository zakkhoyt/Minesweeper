//
//  ZHBoard.m
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/29/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import "ZHBoard.h"

@interface ZHBoard ()
@property (nonatomic, strong) NSMutableArray *bombCells;
@end

@implementation ZHBoard

- (instancetype)initWithSize:(CGSize)size mineCount:(NSUInteger)mineCount {
    self = [super init];
    if (self) {
        _size = size;
        _mineCount = mineCount;
        [self generateBombCells];
    }
    return self;
}

- (void)exposeCell:(ZHCell*)cell{
    
}

- (void)end{
    NSLog(@"Game was ended");
}

#pragma mark Private methods

-(void)generateBombCells{
    for(NSUInteger index = 0; index < _mineCount; index++){
        
    }
}

@end
