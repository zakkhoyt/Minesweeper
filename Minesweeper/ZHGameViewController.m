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

#pragma mark IBActions

- (IBAction)endGameButtonTouchUpInside:(id)sender {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Quit?" message:@"You will lose any progress gained" preferredStyle:UIAlertControllerStyleAlert];
    
    [ac addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }]];
    
    [ac addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { 
    }]];

    [self presentViewController:ac animated:YES completion:NULL];
    
    
}


@end
