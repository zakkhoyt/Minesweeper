//
//  GameViewController.h
//  Minesweeper
//
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@class ZHGame;

@interface ZHGameViewController : UIViewController
@property (nonatomic, strong) ZHGame *game;
@end
