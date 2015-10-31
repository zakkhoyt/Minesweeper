//
//  GameViewController.h
//  Minesweeper
//
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "ZHViewController.h"
#import <SpriteKit/SpriteKit.h>

@class ZHBoard;

@interface ZHSpriteKitGameViewController : ZHViewController
@property (nonatomic, strong) ZHBoard *board;
@end
