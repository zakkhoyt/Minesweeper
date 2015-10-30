//
//  ZHBoard.m
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/29/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import "ZHBoard.h"

@interface ZHBoard ()
@property (nonatomic, strong) NSMutableDictionary *cells;
//@property (nonatomic, strong) NSMutableArray *bombCells;
@end

@implementation ZHBoard

- (instancetype)initWithSize:(CGSize)size mineCount:(NSUInteger)mineCount {
    self = [super init];
    if (self) {
        _size = size;
        _mineCount = mineCount;
        [self generateCells];
    }
    return self;
}

- (void)exposeCell:(ZHCell*)cell{
    
}

- (ZHCell*)cellForKey:(NSString*)key{
    return self.cells[key];
}

- (ZHCell*)cellForIndexPath:(NSIndexPath*)indexPath{
    // Convert indexPath to a key
    NSUInteger index = indexPath.item;
    NSUInteger y = index / (NSUInteger)self.size.width;
    NSUInteger x = index - y * self.size.width;
    return [self cellForKey:[ZHCell keyFromX:x Y:y]];
}


- (void)end{
    NSLog(@"Game was ended");
}

#pragma mark Private methods

-(void)generateCells{

    self.cells = [[NSMutableDictionary alloc]initWithCapacity:self.size.width * self.size.height];
    for(NSUInteger y = 0; y < self.size.height; y++){
        for(NSUInteger x = 0; x < self.size.width; x++){
            ZHCell *cell = [[ZHCell alloc]initWithX:x Y:y];
            self.cells[cell.key] = cell;
        }
    }
    
    for(NSUInteger index = 0; index <= _mineCount; index++){
        NSUInteger x = arc4random() % (NSUInteger)self.size.width;
        NSUInteger y = arc4random() % (NSUInteger)self.size.height;
        NSString *key = [ZHCell keyFromX:x Y:y];
        ZHCell *cell = self.cells[key];
        // TODO: Check to see if it's already a bomb and try again
        cell.isBomb = YES;
        NSLog(@"Set bomb at %@", key);
        
    }
}

@end
