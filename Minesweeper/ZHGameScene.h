//
//  GameScene.h
//  Minesweeper
//

//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class ZHBoard;

@interface ZHGameScene : SKScene
@property (nonatomic, strong) ZHBoard *board;
-(void)renderBoard;
@end
