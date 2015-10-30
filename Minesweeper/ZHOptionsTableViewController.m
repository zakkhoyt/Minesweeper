//
//  ZHOptionsTableViewController.m
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/29/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import "ZHOptionsTableViewController.h"
#import "ZHBoard.h"
#import "ZHGameViewController.h"

@interface ZHOptionsTableViewController ()

@end

@implementation ZHOptionsTableViewController


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"SegueOptionsToGame"]){
        ZHGameViewController *vc = segue.destinationViewController;
        vc.board = sender;
    }
}
#pragma mark IBActions

- (IBAction)startButtonTouchUpInside:(id)sender {
    ZHBoard *board = [[ZHBoard alloc]initWithSize:CGSizeMake(8, 8) mineCount:10];
    [self performSegueWithIdentifier:@"SegueOptionsToGame" sender:board];
}

@end
