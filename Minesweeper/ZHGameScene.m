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
    [self drawCells];
}


#pragma mark Private methods

-(void)didMoveToView:(SKView *)view {
    [self renderBoard];
}


#ifndef TARGET_OS_TV
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
#endif


-(void)invokeTapAtPoint:(CGPoint)point{
    // Get all nodes at touch point
    NSArray *nodes = [self nodesAtPoint:point];
    
    // Ensure we get the cellNode, not the gridNode
    [nodes enumerateObjectsUsingBlock:^(SKNode *node, NSUInteger idx, BOOL * _Nonnull stop) {
        //            if([node.name isEqualToString:@"cellNode"]){
//        if([node.name rangeOfString:@"cellNode"].location != NSNotFound){
        if([node isKindOfClass:[ZHCellNode class]]){
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
}

-(CGFloat)xSpacing{
    return self.frame.size.width / self.board.size.width;
}

-(CGFloat)ySpacing{
    return self.frame.size.height / self.board.size.height;
}



-(void)drawCells{
    CGFloat xSpacing = [self xSpacing];
    CGFloat ySpacing = [self ySpacing];
    
    for(NSUInteger y = 0; y <= self.board.size.height; y++){
        for(NSUInteger x = 0; x <= self.board.size.width; x++){
            NSString *key = [ZHCell keyFromX:x Y:y];
            ZHCell *cell = [self.board cellForKey:key];
            
            ZHCellNode *cellNode = [ZHCellNode node];
            cellNode.cell = cell;
            cellNode.name = [NSString stringWithFormat:@"cellNode:%@", cell.key];
            cellNode.position = CGPointMake(x * xSpacing + xSpacing / 2.0,
                                            y * ySpacing + ySpacing / 2.0);
            
            CGRect rect = CGRectMake(-xSpacing / 2.0, -ySpacing / 2.0, xSpacing, ySpacing);
            SKShapeNode *backgroundNode = [SKShapeNode shapeNodeWithRect:rect];
            backgroundNode.name = @"backgroundNode";
            backgroundNode.fillColor = [UIColor purpleColor];
            backgroundNode.strokeColor = [UIColor orangeColor];
            [cellNode addChild:backgroundNode];
            
            
            SKSpriteNode *mineNode = [SKSpriteNode spriteNodeWithImageNamed:@"mine"];
            mineNode.name = @"mineNode";
            mineNode.size = CGSizeMake(xSpacing, ySpacing);
            mineNode.yScale = xSpacing / ySpacing;
            mineNode.hidden = YES;
            [cellNode addChild:mineNode];
            
            [self addChild:cellNode];
        }
    }
    [self updateCells];
}


-(void)updateCells{
    [self.children enumerateObjectsUsingBlock:^(SKNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[ZHCellNode class]]){
            ZHCellNode *cellNode = (ZHCellNode*)obj;
            ZHCell *cell = cellNode.cell;
            SKShapeNode *backgroundNode = (SKShapeNode*)[cellNode childNodeWithName:@"backgroundNode"];
            SKSpriteNode *mineNode = (SKSpriteNode*)[cellNode childNodeWithName:@"mineNode"];
            
            // Set cell color and text
            if(cell.isPlayed == YES){
                backgroundNode.fillColor = cell.isCheat ? [UIColor zhCheatColor] : [UIColor zhPlayedColor];
                //                cellNode.strokeColor = [UIColor clearColor];
                if(cell.adjacentBombCount > 0){
                    // Add a label
                    SKLabelNode *labelNode = [[SKLabelNode alloc]initWithFontNamed:@"Halvetica"];
                    labelNode.name = @"labelNode";
#ifdef TARGET_OS_TV
                    labelNode.xScale = 1.0;
                    labelNode.yScale = 1.0;
                    labelNode.fontSize = 16;
#else
                    
                    labelNode.xScale = 1.5;
                    labelNode.yScale = 1.0;
                    labelNode.fontSize = 8;
#endif
                    
                    labelNode.text = [NSString stringWithFormat:@"%lu", (unsigned long)cell.adjacentBombCount];
                    labelNode.fontColor = [UIColor zhTextColor];
                    //                    labelNode.position = CGPointMake(cell.x * xSpacing + xSpacing/2.0, cell.y * ySpacing + ySpacing/2.0);
                    [labelNode setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
                    [labelNode setVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter];
                    [cellNode addChild:labelNode];
                }
            } else {
                backgroundNode.fillColor = [UIColor zhUnplayedColor];
                //   cellNode.strokeColor = [UIColor zhGridColor];
            }
            
            // If mine, render mine
            if(cell.isBomb == YES && cell.bombVisible){
                backgroundNode.fillColor = [UIColor zhMineColor];
                mineNode.hidden = NO;
            }

        }
    }];
}
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}



@end
