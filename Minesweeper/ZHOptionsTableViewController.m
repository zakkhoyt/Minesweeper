//
//  ZHOptionsTableViewController.m
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/29/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import "ZHOptionsTableViewController.h"
#import "ZHBoard.h"
#import "ZHSpriteKitGameViewController.h"
#import "ZHUIKitGameViewController.h"
#import "ZHUserDefaults.h"
#import "ZHTitleHeaderView.h"

typedef enum {
    ZHRenderTypeUIKit = 0,
    ZHRenderTypeSpriteKit = 1,
} ZHRenderType;


static NSString *SegueOptionsToGame = @"SegueOptionsToGame";
static NSString *SegueOptionsToGameCV = @"SegueOptionsToGameCV";

@interface ZHOptionsTableViewController ()
@property (weak, nonatomic) IBOutlet UIStepper *boardWidthStepper;
@property (weak, nonatomic) IBOutlet UILabel *boardWidthLabel;
@property (weak, nonatomic) IBOutlet UIStepper *mineCountStepper;
@property (weak, nonatomic) IBOutlet UILabel *mineCountLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *renderTypeSegment;

@end

@interface ZHOptionsTableViewController (UITableViewDelegate) <UITableViewDelegate>
@end

@implementation ZHOptionsTableViewController

#pragma mark Private UIViewController overrides
- (void)viewDidLoad{
    [super viewDidLoad];
    [self refreshUI];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:SegueOptionsToGame]){
        ZHSpriteKitGameViewController *vc = segue.destinationViewController;
        vc.board = sender;
    } else if([segue.identifier isEqualToString:SegueOptionsToGameCV]){
        ZHUIKitGameViewController *vc = segue.destinationViewController;
        vc.board = sender;
    }
}

#pragma mark Private methods
-(void)refreshUI{
    NSUInteger boardWidth = [ZHUserDefaults boardWidth];
    self.boardWidthStepper.value = boardWidth;
    self.boardWidthLabel.text = [NSString stringWithFormat:@"%lux%lu",
                                 (unsigned long)boardWidth,
                                 (unsigned long)[self calculateBoardHeight]];
    
    NSUInteger mineCount = [ZHUserDefaults mineCount];
    self.mineCountStepper.value = mineCount;
    self.mineCountLabel.text = [NSString stringWithFormat:@"%lu",
                                (unsigned long)mineCount];

    NSUInteger renderType = [ZHUserDefaults renderType];
    self.renderTypeSegment.selectedSegmentIndex = renderType;
}

-(NSUInteger)calculateBoardHeight{
    NSUInteger boardWidth = [ZHUserDefaults boardWidth];
    NSUInteger boardHeight = boardWidth * (self.view.bounds.size.height - 74) / self.view.bounds.size.width;
    return boardHeight;
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

- (IBAction)renderTypeSegmentValueChanged:(UISegmentedControl*)sender {
    [ZHUserDefaults setRenderType:sender.selectedSegmentIndex];
    [self refreshUI];
}

- (IBAction)startButtonTouchUpInside:(id)sender {
    NSUInteger mineCount = [ZHUserDefaults mineCount];
    NSUInteger boardWidth = [ZHUserDefaults boardWidth];
    NSUInteger boardHeight = [self calculateBoardHeight];
    ZHBoard *board = [[ZHBoard alloc]initWithSize:CGSizeMake(boardWidth, boardHeight) mineCount:mineCount];
    
    if([ZHUserDefaults renderType] == ZHRenderTypeUIKit){
        [self performSegueWithIdentifier:SegueOptionsToGameCV sender:board];
    } else if([ZHUserDefaults renderType] == ZHRenderTypeSpriteKit){
        [self performSegueWithIdentifier:SegueOptionsToGame sender:board];
    }
}

@end


@implementation ZHOptionsTableViewController (UITableViewDelegate)
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 142;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ZHTitleHeaderView *view = [[[NSBundle mainBundle]loadNibNamed:@"ZHTitleHeaderView" owner:self options:nil] firstObject];
    return view;
}

@end




