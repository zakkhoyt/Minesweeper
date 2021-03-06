//
//  ZHCellNode.h
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/30/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class ZHCell;

@interface ZHCellNode : SKShapeNode
@property (nonatomic, strong) ZHCell *cell;
@end
