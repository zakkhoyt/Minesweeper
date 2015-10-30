//
//  ZHOptionsTableViewController.m
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/29/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import "ZHOptionsTableViewController.h"
#import "ZHGame.h"
#import "ZHGameViewController.h"

@interface ZHOptionsTableViewController ()
@property (nonatomic, strong) ZHGame *game;
@end

@implementation ZHOptionsTableViewController


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"SegueOptionsToGame"]){
        ZHGameViewController *vc = segue.destinationViewController;
        vc.game = sender;
    }
}
#pragma mark IBActions

- (IBAction)startButtonTouchUpInside:(id)sender {
    _game = [[ZHGame alloc]initWithSize:CGSizeMake(8, 8) mineCount:10];
    [self performSegueWithIdentifier:@"SegueOptionsToGame" sender:_game];
}

@end
