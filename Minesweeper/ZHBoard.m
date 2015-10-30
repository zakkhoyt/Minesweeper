//
//  ZHBoard.m
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/29/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import "ZHBoard.h"

@interface ZHBoard ()
@property (nonatomic, strong) NSMutableArray *cells;
@end

@implementation ZHBoard


- (instancetype)initWithSize:(CGSize)size mineCount:(NSUInteger)mineCount {
    self = [super init];
    if (self) {
        _size = size;
        _mineCount = mineCount;
//        [self generateCells];
    }
    return self;
}



#pragma mark Private methods
-(void)generateBombCells{
    
}

@end
