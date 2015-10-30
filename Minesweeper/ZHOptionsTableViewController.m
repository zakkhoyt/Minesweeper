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
#import "ZHGameCollectionViewController.h"
#import "ZHUserDefaults.h"


static NSString *SegueOptionsToGame = @"SegueOptionsToGame";
static NSString *SegueOptionsToGameCV = @"SegueOptionsToGameCV";

@interface ZHOptionsTableViewController ()
@property (weak, nonatomic) IBOutlet UIStepper *boardWidthStepper;
@property (weak, nonatomic) IBOutlet UILabel *boardWidthLabel;
@property (weak, nonatomic) IBOutlet UIStepper *mineCountStepper;
@property (weak, nonatomic) IBOutlet UILabel *mineCountLabel;
@end

@implementation ZHOptionsTableViewController

#pragma mark Private UIViewController overrides
- (void)viewDidLoad{
    [super viewDidLoad];
    [self refreshUI];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:SegueOptionsToGame]){
        ZHGameViewController *vc = segue.destinationViewController;
        vc.board = sender;
    } else if([segue.identifier isEqualToString:SegueOptionsToGameCV]){
        ZHGameCollectionViewController *vc = segue.destinationViewController;
        vc.board = sender;
    }
}

#pragma mark Private methods
-(void)refreshUI{
    NSUInteger boardWidth = [ZHUserDefaults boardWidth];
    self.boardWidthStepper.value = boardWidth;
    self.boardWidthLabel.text = [NSString stringWithFormat:@"%lux%lu",
                                 (unsigned long)boardWidth,
                                 (unsigned long)boardWidth];
    
    NSUInteger mineCount = [ZHUserDefaults mineCount];
    self.mineCountStepper.value = mineCount;
    self.mineCountLabel.text = [NSString stringWithFormat:@"%lu",
                                (unsigned long)mineCount];

}

#pragma mark Private IBActions

- (IBAction)sizeStepperValueChanged:(UIStepper*)sender {
    [ZHUserDefaults setBoardWidth:sender.value];
    [self refreshUI];
}

- (IBAction)minesStepperValueChanged:(UIStepper*)sender {
    [ZHUserDefaults setMineCount:sender.value];
    [self refreshUI];
}

- (IBAction)startButtonTouchUpInside:(id)sender {
    NSUInteger boardWidth = [ZHUserDefaults boardWidth];
    NSUInteger mineCount = [ZHUserDefaults mineCount];
    ZHBoard *board = [[ZHBoard alloc]initWithSize:CGSizeMake(boardWidth, boardWidth) mineCount:mineCount];
    //[self performSegueWithIdentifier:SegueOptionsToGame sender:board];
    [self performSegueWithIdentifier:SegueOptionsToGameCV sender:board];
}

@end
