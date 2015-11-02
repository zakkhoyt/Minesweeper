//
//  GameScene.m
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/29/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "ZHGameScene.h"
#import "ZHBoard.h"
#import "ZHCellNode.h"
#import "UIColor+ZH.h"

@implementation ZHGameScene

#pragma mark Public methods
-(void)renderBoard{
    // Remove all sprites
    [self.children enumerateObjectsUsingBlock:^(SKNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromParent];
    }];
    
    // Render cells then grid
    [self renderCells];
    if(self.board.grid == YES){
        [self renderGrid];
    }
}


#pragma mark Private methods

-(void)didMoveToView:(SKView *)view {
    [self renderBoard];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [touches enumerateObjectsUsingBlock:^(UITouch *touch, BOOL * _Nonnull stop) {
        // Get all nodes at touch point
        CGPoint point = [touch locationInNode:self];
        NSArray *nodes = [self nodesAtPoint:point];
        
        // Ensure we get the cellNode, not the gridNode
        [nodes enumerateObjectsUsingBlock:^(SKNode *node, NSUInteger idx, BOOL * _Nonnull stop) {
//            if([node.name isEqualToString:@"cellNode"]){
            if([node.name rangeOfString:@"cellNode"].location != NSNotFound){
                ZHCellNode *cellNode = (ZHCellNode*)node;
                ZHCell *cell = cellNode.cell;
                
                if(cell.isPlayed == NO){
                    self.board.roundCount++;
                    [self.board playCell:cell completionBlock:^{
                        [self renderBoard];                
                    }];
                    *stop = YES;
                    return;
                }
            }
        }];
    }];
}

-(CGFloat)xSpacing{
    return self.frame.size.width / self.board.size.width;
}

-(CGFloat)ySpacing{
    return self.frame.size.height / self.board.size.height;
}


-(void)renderGrid{
    // Draw vertical lines
    for(NSUInteger x = 0; x <= self.board.size.width; x++){
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, x * [self xSpacing], 0);
        CGPathAddLineToPoint(path, nil, x * [self xSpacing], self.frame.size.height);
        SKShapeNode *line = [SKShapeNode shapeNodeWithPath:path];
        line.name = @"line";
        line.strokeColor = [UIColor greenColor];
        [self addChild:line];
    }
    
    // Draw horizontal lines
    for(NSUInteger y = 0; y <= self.board.size.height; y++){
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, 0, y * [self ySpacing]);
        CGPathAddLineToPoint(path, nil, self.frame.size.width, y * [self ySpacing]);
        SKShapeNode *line = [SKShapeNode shapeNodeWithPath:path];
        line.name = @"line";
        line.strokeColor = [UIColor greenColor];
        [self addChild:line];
    }
}

-(void)renderCells{
    CGFloat xSpacing = [self xSpacing];
    CGFloat ySpacing = [self ySpacing];
    for(NSUInteger y = 0; y <= self.board.size.height; y++){
        for(NSUInteger x = 0; x <= self.board.size.width; x++){
            NSString *key = [ZHCell keyFromX:x Y:y];
            ZHCell *cell = [self.board cellForKey:key];
 
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathMoveToPoint(path, nil, cell.x * xSpacing, cell.y * ySpacing);
            CGPathAddLineToPoint(path, nil, cell.x * xSpacing + xSpacing, cell.y * ySpacing);
            CGPathAddLineToPoint(path, nil, cell.x * xSpacing + xSpacing, cell.y * ySpacing + ySpacing);
            CGPathAddLineToPoint(path, nil, cell.x * xSpacing, cell.y * ySpacing + ySpacing);

            // Create node to contain cell
            ZHCellNode *cellNode = [ZHCellNode shapeNodeWithPath:path];
            cellNode.cell = cell;
            cellNode.name = [NSString stringWithFormat:@"cellNode:%@", cell.key];
            cellNode.strokeColor = [UIColor clearColor];
            [self addChild:cellNode];
            
            // Set cell color and text
            if(cell.isPlayed == YES){
                cellNode.fillColor = cell.isCheat ? [UIColor zhCheatColor] : [UIColor zhPlayedColor];
//                cellNode.strokeColor = [UIColor clearColor];
                if(cell.adjacentBombCount > 0){
                    // Add a label
                    SKLabelNode *labelNode = [[SKLabelNode alloc]initWithFontNamed:@"Halvetica"];
                    labelNode.name = @"labelNode";
                    labelNode.xScale = 1.5;
                    labelNode.yScale = 1.0;
                    labelNode.fontSize = 8;
                    labelNode.text = [NSString stringWithFormat:@"%lu", (unsigned long)cell.adjacentBombCount];
                    labelNode.fontColor = [UIColor zhTextColor];
                    labelNode.position = CGPointMake(cell.x * xSpacing + xSpacing/2.0, cell.y * ySpacing + ySpacing/2.0);
                    [labelNode setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
                    [labelNode setVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter];
                    [self addChild:labelNode];
                }
            } else {
                cellNode.fillColor = [UIColor zhUnplayedColor];
             //   cellNode.strokeColor = [UIColor zhGridColor];
            }
            
            // If mine, render mine
            if(cell.isBomb == YES && cell.bombVisible){
                cellNode.fillColor = [UIColor zhMineColor];
                SKSpriteNode *mineNode = [SKSpriteNode spriteNodeWithImageNamed:@"mine"];
                mineNode.name = @"mineNode";
                mineNode.position = CGPointMake(cell.x * xSpacing + xSpacing/2.0, cell.y * ySpacing + ySpacing/2.0);
                mineNode.size = CGSizeMake(xSpacing, ySpacing);
                [self addChild:mineNode];
            }
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}



@end
