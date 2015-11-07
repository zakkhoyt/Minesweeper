//
//  ZHTVOptionsViewController.m
//  MinesweeperTVOS
//
//  Created by Zakk Hoyt on 11/6/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import "ZHTVOptionsViewController.h"
#import "ZHBoard.h"
#import "ZHUIKitGameViewController.h"
#import "ZHSpriteKitGameViewController.h"

static NSString *SegueOptionsToGame = @"SegueOptionsToGame";
static NSString *SegueOptionsToGameCV = @"SegueOptionsToGameCV";


@interface ZHTVOptionsViewController ()
@property (nonatomic, weak) IBOutlet UITableView *sizeTableView;
@property (nonatomic, weak) IBOutlet UITableView *difficultyTableView;
@end

@interface ZHTVOptionsViewController (UITableViewDataSource) <UITableViewDataSource>

@end

@interface ZHTVOptionsViewController (UITableViewDelegate) <UITableViewDelegate>

@end

@implementation ZHTVOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
    // Dispose of any resources that can be recreated.
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


-(NSUInteger)calculateBoardHeight{
    NSUInteger boardWidth = 30;
    NSUInteger boardHeight = boardWidth * (self.view.bounds.size.height - 74) / self.view.bounds.size.width;
    return boardHeight;
}


-(IBAction)startButtonPrimaryActionTriggered:(UIButton*)sender{
    NSLog(@"start");
    NSUInteger mineCount = 30;
    NSUInteger boardWidth = 30;
    NSUInteger boardHeight = [self calculateBoardHeight];
    ZHBoard *board = [[ZHBoard alloc]initWithSize:CGSizeMake(boardWidth, boardHeight) mineCount:mineCount];
    board.grid = YES;
//    if([ZHUserDefaults renderType] == ZHRenderTypeUIKit){
        [self performSegueWithIdentifier:SegueOptionsToGameCV sender:board];
//    } else if([ZHUserDefaults renderType] == ZHRenderTypeSpriteKit){
//        [self performSegueWithIdentifier:SegueOptionsToGame sender:board];
//    }

}

@end

@implementation ZHTVOptionsViewController (UITableViewDataSource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.sizeTableView){
        return 23; // 8 - 30
    } else if(tableView == self.difficultyTableView){
        return 5;
    } else {
        NSLog(@"Unknown tableView");
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == self.sizeTableView){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SizeCell"];
        return cell;
    } else if(tableView == self.difficultyTableView){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DifficultyCell"];
        return cell;
        
    } else {
        return nil;
    }
}

@end

@implementation ZHTVOptionsViewController (UITableViewDelegate)

@end
