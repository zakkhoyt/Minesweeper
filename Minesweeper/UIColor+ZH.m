//
//  UIColor+ZH.m
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/31/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import "UIColor+ZH.h"

@implementation UIColor (ZH)

+(UIColor*)zhGridColor{
    return [UIColor greenColor];
}

+(UIColor*)zhUnplayedColor{
      return [UIColor blackColor];
}

+(UIColor*)zhPlayedColor{
    return [UIColor whiteColor];
}

+(UIColor*)zhMineColor{
    return [UIColor colorWithRed:0.3 green:0 blue:0 alpha:1];
}

+(UIColor*)zhTextColor{
    return [UIColor darkTextColor];
}

@end
