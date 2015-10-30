//
//  ZHGame.h
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/29/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHGame : NSObject

@property (nonatomic) CGSize size;
@property (nonatomic) NSUInteger mineCount;

@property (nonatomic) NSUInteger roundCount;
@property (nonatomic) NSUInteger secondsCount;

- (instancetype)initWithSize:(CGSize)size mineCount:(NSUInteger)mineCount;
- (void)end;
@end
