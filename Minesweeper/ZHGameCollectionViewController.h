//
//  ZHGameCollectionViewController.h
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/30/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHBoard;

@interface ZHGameCollectionViewController : UIViewController
@property (nonatomic, strong) ZHBoard *board;
@end
