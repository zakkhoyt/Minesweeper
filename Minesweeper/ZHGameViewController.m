//
//  GameViewController.m
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/29/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

//  End game button
//  Validate button
//  Cheat button


#import "ZHGameViewController.h"
#import "ZHGameScene.h"
#import "SKScene+Unarchive.h"
#import "ZHBoard.h"

@interface ZHGameViewController ()
@property (weak, nonatomic) IBOutlet SKView *skView;

@end

@implementation ZHGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Configure the view.

    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    self.skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    ZHGameScene *scene = [ZHGameScene unarchiveFromFile:@"ZHGameScene"];
    scene.scaleMode = SKSceneScaleModeAspectFit;
    scene.board = _board;
    
    // Present the scene.
    [self.skView presentScene:scene];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark IBActions

- (IBAction)endGameButtonTouchUpInside:(id)sender {
    [_board end];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
