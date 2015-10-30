//
//  GameScene.m
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/29/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "ZHGameScene.h"
#import "ZHBoard.h"

@implementation ZHGameScene


#pragma mark Private methods

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    myLabel.text = [NSString stringWithFormat:@"%lux%lu:%lu",
                    (unsigned long)_board.size.width,
                    (unsigned long)_board.size.height,
                    (unsigned long)_board.mineCount];
    myLabel.fontSize = 45;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:myLabel];
    
    [self renderBoard];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.xScale = 0.5;
        sprite.yScale = 0.5;
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}

-(CGFloat)xSpacing{
    return self.frame.size.width / self.board.size.width;
}

-(CGFloat)ySpacing{
//    return self.frame.size.height / self.board.size.height;
    return [self xSpacing];
}

-(void)renderBoard{
    [self renderGrid];
    [self renderCells];
}

-(void)renderGrid{
    for(NSUInteger x = 0; x <= self.board.size.width; x++){
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, x * [self xSpacing], 0);
        CGPathAddLineToPoint(path, nil, x * [self xSpacing], self.frame.size.height);
        SKShapeNode *line = [SKShapeNode shapeNodeWithPath:path];
        line.name = @"line";
        line.strokeColor = [UIColor greenColor];
        [self addChild:line];
    }
    
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
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}



@end
