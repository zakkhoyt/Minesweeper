//
//  ZHCell.h
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/29/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHCell : NSObject
@property (nonatomic) NSUInteger x;
@property (nonatomic) NSUInteger y;
@property (nonatomic) BOOL isBomb;
@property (nonatomic) NSUInteger adjacentBombCount;

-(NSString*)key;
@end
