//
//  ZHSKCursorView.m
//  TVOSGame
//
//  Created by Zakk Hoyt on 11/11/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import "ZHSKCursorView.h"

@interface ZHSKCursorView () <UIFocusEnvironment>
@property (nonatomic) CGFloat firstX;
@property (nonatomic) CGFloat firstY;
@property (nonatomic, strong) UIImageView *cursorImageView;
@property (nonatomic, strong) ZHSKCursorViewPointBlock tapBlock;
@end

@implementation ZHSKCursorView

-(void)setTapBlock:(ZHSKCursorViewPointBlock)tapBlock{
    _tapBlock = tapBlock;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if(self.cursorImageView == nil){
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
        [self addGestureRecognizer:panGesture];
        
        _firstX = self.center.x;
        _firstY = self.center.y;
        
        UIImageView *iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shovel"]];
        self.cursorImageView = iv;
        self.cursorImageView.frame = CGRectMake(0, 0, 64, 64);
        self.cursorImageView.contentMode = UIViewContentModeScaleAspectFit;
//        self.cursorImageView.layer.borderColor = [UIColor greenColor].CGColor;
//        self.cursorImageView.layer.borderWidth = 1.0;
        self.cursorImageView.center = self.center;
        [self addSubview:self.cursorImageView];
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.cursorImageView.layer.borderColor = [UIColor greenColor].CGColor;
    self.cursorImageView.layer.borderWidth = 1.0;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.cursorImageView.layer.borderColor = [UIColor clearColor].CGColor;
    self.cursorImageView.layer.borderWidth = 0.0;
    
    if(self.tapBlock){
        self.tapBlock(CGPointMake(_firstX, _firstY));
    }
}


-(void)panGesture:(UIPanGestureRecognizer*)sender{
    
    // Get point in view
    CGPoint point = [sender translationInView:self];
    
    // Clip to bounds
    CGFloat x = _firstX+point.x;
    x = MIN(x, self.bounds.size.width);
    x = MAX(x, 0);
    
    CGFloat y = _firstY+point.y;
    y = MIN(y, self.bounds.size.height);
    y = MAX(y, 0);
    
    
    // Update cursor position
    CGPoint cursorPoint = CGPointMake(x, y);
    self.cursorImageView.center = cursorPoint;
    
    // Store for next time
    if(sender.state == UIGestureRecognizerStateEnded){
        _firstX = cursorPoint.x;
        _firstY = cursorPoint.y;
    }
    
}

- (BOOL)shouldUpdateFocusInContext:(UIFocusUpdateContext *)context{
    return YES;
}

@end