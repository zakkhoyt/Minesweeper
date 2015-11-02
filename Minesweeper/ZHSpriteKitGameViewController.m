//
//  GameViewController.m
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/29/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "ZHSpriteKitGameViewController.h"
#import "ZHGameScene.h"
#import "ZHBoard.h"

@interface ZHSpriteKitGameViewController ()
@property (weak, nonatomic) IBOutlet SKView *skView;
@property (nonatomic, strong) ZHGameScene *scene;
@property (weak, nonatomic) IBOutlet UILabel *roundsLabel;
@property (weak, nonatomic) IBOutlet UILabel *minesLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end

@implementation ZHSpriteKitGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    self.skView.ignoresSiblingOrder = YES;
    
    self.scene = [[ZHGameScene alloc]initWithSize:self.skView.bounds.size];
    self.scene.scaleMode = SKSceneScaleModeFill;
    self.scene.board = self.board;
    
    // Present the scene.
    [self.skView presentScene:self.scene];
    
    NSLog(@"%@", NSStringFromCGRect(self.skView.layer.bounds));
    
    __weak typeof(self) welf = self;
    
    [self.board setCellExplodedBlock:^(ZHCell *cell) {
        [welf.board showBombs];
        [welf refreshUI];
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"BOOM!" message:@"You lose!" preferredStyle:UIAlertControllerStyleAlert];
        
        [ac addAction:[UIAlertAction actionWithTitle:@"New Game" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [welf.navigationController popToRootViewControllerAnimated:YES];
        }]];
        
        [ac addAction:[UIAlertAction actionWithTitle:@"Stay and learn" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [welf presentViewController:ac animated:YES completion:NULL];
    }];
    
    [self.board setSecondElapsedBlock:^(NSUInteger seconds) {
        welf.timeLabel.text = [NSString stringWithFormat:@"Sec:%lu", (unsigned long)seconds];
    }];

    
}

-(void)refreshUI{
    [self.scene renderBoard];
    self.roundsLabel.text = [NSString stringWithFormat:@"Rounds:%lu", (unsigned long)self.board.roundCount];
    self.minesLabel.text = [NSString stringWithFormat:@"Mines:%lu", (unsigned long)self.board.mineCount];
    self.timeLabel.text = [NSString stringWithFormat:@"Sec:%lu", (unsigned long)self.board.secondsCount];
}


#pragma mark IBActions

- (IBAction)quitButtonTouchUpInside:(id)sender {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Quit?" message:@"You will lose any progress gained" preferredStyle:UIAlertControllerStyleAlert];
    
    [ac addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }]];
    
    [ac addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [self presentViewController:ac animated:YES completion:NULL];
    
}

- (IBAction)validateButtonTouchUpInside:(id)sender {
    if([self.board validate] == YES){
        NSLog(@"Validated!");
        
        NSString *message = nil;
        if(self.board.cheatCount > 0){
            message = [NSString stringWithFormat:@"But not really because you cheated %lu times. All mines \"discovered\"!", (unsigned long)self.board.cheatCount];
        } else {
            message = @"All mines discovered!";
        }
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"You Win!" message:message preferredStyle:UIAlertControllerStyleAlert];

        [ac addAction:[UIAlertAction actionWithTitle:@"New Game" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }]];
        
        [ac addAction:[UIAlertAction actionWithTitle:@"Stay and learn" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        
        [self presentViewController:ac animated:YES completion:NULL];
    } else {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"You've got work to do..." message:@"Keep trying!" preferredStyle:UIAlertControllerStyleAlert];
        
        [ac addAction:[UIAlertAction actionWithTitle:@"I will!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [self presentViewController:ac animated:YES completion:NULL];
    }
}

- (IBAction)cheatButtonTouchUpInside:(id)sender {
    [self.board cheat];
    [self refreshUI];
}


@end
