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
@property (nonatomic) NSUInteger sizeIndex;
@property (nonatomic) NSUInteger difficultyIndex;
@end

@interface ZHTVOptionsViewController (UITableViewDataSource) <UITableViewDataSource>

@end

@interface ZHTVOptionsViewController (UITableViewDelegate) <UITableViewDelegate>

@end

@implementation ZHTVOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sizeIndex = 2;
    self.difficultyIndex = 2;
    [self.sizeTableView reloadData];
    [self.sizeTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.sizeIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    UITableViewCell *cell = [self.sizeTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.sizeIndex inSection:0]];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [self.difficultyTableView reloadData];
    [self.difficultyTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.difficultyIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    UITableViewCell *cell2 = [self.difficultyTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.difficultyIndex inSection:0]];
    cell2.accessoryType = UITableViewCellAccessoryCheckmark;

    for(NSUInteger index = 5; index < 100; index+=5){
        NSUInteger boardWidth = index;
        NSUInteger boardHeight = boardWidth * (self.view.bounds.size.height - 115) / self.view.bounds.size.width;
        NSLog(@"%lux%lu", (unsigned long) boardWidth, (unsigned long) boardHeight);
    }
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




-(IBAction)startButtonPrimaryActionTriggered:(UIButton*)sender{
    NSLog(@"start");

    NSUInteger boardWidth = 20 + 10 * self.sizeIndex;
    NSUInteger boardHeight = boardWidth * (self.view.bounds.size.height - 115) / self.view.bounds.size.width;
    NSUInteger mineCount = boardWidth * (self.difficultyIndex + 1);
    ZHBoard *board = [[ZHBoard alloc]initWithSize:CGSizeMake(boardWidth, boardHeight) mineCount:mineCount];
    board.grid = YES;
//    if([ZHUserDefaults renderType] == ZHRenderTypeUIKit){
        [self performSegueWithIdentifier:SegueOptionsToGameCV sender:board];
//            [self performSegueWithIdentifier:SegueOptionsToGame sender:board];
//    } else if([ZHUserDefaults renderType] == ZHRenderTypeSpriteKit){
//        [self performSegueWithIdentifier:SegueOptionsToGame sender:board];
//    }

}

@end

@implementation ZHTVOptionsViewController (UITableViewDataSource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.sizeTableView){
        return 7;
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
        
        switch (indexPath.item) {
            case 0:
                cell.textLabel.text = @"20x10";
                break;
            case 1:
                cell.textLabel.text = @"30x15";
                break;
            case 2:
                cell.textLabel.text = @"40x20";
                break;
            case 3:
                cell.textLabel.text = @"50x25";
                break;
            case 4:
                cell.textLabel.text = @"60x30";
                break;
            case 5:
                cell.textLabel.text = @"70x35";
                break;
            case 6:
                cell.textLabel.text = @"80x40";
                break;
            default:
                break;
        }

        return cell;
    } else if(tableView == self.difficultyTableView){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DifficultyCell"];
        switch (indexPath.item) {
            case 0:
                cell.textLabel.text = @"Easy";
                break;
            case 1:
                cell.textLabel.text = @"Medium";
                break;
            case 2:
                cell.textLabel.text = @"Hard";
                break;
            case 3:
                cell.textLabel.text = @"Expert";
                break;
            case 4:
                cell.textLabel.text = @"Heroic";
                break;
                
            default:
                break;
        }
        return cell;
        
    } else {
        return nil;
    }
}

@end

@implementation ZHTVOptionsViewController (UITableViewDelegate)

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(tableView == self.sizeTableView){
        return @"Board Size";
    } else if(tableView == self.difficultyTableView){
        return @"Difficulty";
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.sizeTableView){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if(cell.selected){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }

    } else if(tableView == self.difficultyTableView){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

        if(cell.selected){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }

    } else {
        NSLog(@"Unknown tableView");
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    if(tableView == self.sizeTableView){
        self.sizeIndex = indexPath.item;
    } else if(tableView == self.difficultyTableView){
        self.difficultyIndex = indexPath.item;
    }

}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;

}


@end
