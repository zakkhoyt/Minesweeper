//
//  GameScene.h
//  Minesweeper
//

//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class ZHGame;

@interface ZHGameScene : SKScene
@property (nonatomic, strong) ZHGame *game;
-(void)renderBoard;
@end
