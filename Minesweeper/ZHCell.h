//
//  ZHCell.h
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/29/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHCell : NSObject

+ (NSString*)keyFromX:(NSUInteger)x Y:(NSUInteger)y;
- (instancetype)initWithX:(NSUInteger)x Y:(NSUInteger)y;
- (NSString*)key;

@property (nonatomic) NSUInteger x;
@property (nonatomic) NSUInteger y;
@property (nonatomic) BOOL isBomb;
@property (nonatomic) BOOL bombVisible;
@property (nonatomic) BOOL isPlayed;
@property (nonatomic) NSUInteger adjacentBombCount;
@property (nonatomic) BOOL isCheat;
@end
