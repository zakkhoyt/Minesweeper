//
//  ZHUserDefaults.m
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/30/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import "ZHUserDefaults.h"

@implementation ZHUserDefaults

static NSString *ZHUserDefaultsBoardWidth = @"ZHUserDefaultsBoardWidth";
+(NSUInteger)boardWidth{
    NSNumber *num = [[NSUserDefaults standardUserDefaults] objectForKey:ZHUserDefaultsBoardWidth];
    if(num == nil){
        return 8;
    }
    return num.unsignedIntegerValue;
}

+(void)setBoardWidth:(NSUInteger)boardWidth{
    [[NSUserDefaults standardUserDefaults] setObject:@(boardWidth) forKey:ZHUserDefaultsBoardWidth];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

static NSString *ZHUserDefaultsMineCount = @"ZHUserDefaultsMineCount";
+(NSUInteger)mineCount{
    NSNumber *num = [[NSUserDefaults standardUserDefaults] objectForKey:ZHUserDefaultsMineCount];
    if(num == nil){
        return 10;
    }
    return num.unsignedIntegerValue;
    
}

+(void)setMineCount:(NSUInteger)mineCount{
    [[NSUserDefaults standardUserDefaults] setObject:@(mineCount) forKey:ZHUserDefaultsMineCount];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

static NSString *ZHUserDefaultsRenderType = @"ZHUserDefaultsRenderType";
+(NSUInteger)renderType{
    NSNumber *num = [[NSUserDefaults standardUserDefaults] objectForKey:ZHUserDefaultsRenderType];
    if(num == nil){
        return 0;
    }
    return num.unsignedIntegerValue;
    
}
+(void)setRenderType:(NSUInteger)renderType{
    [[NSUserDefaults standardUserDefaults] setObject:@(renderType) forKey:ZHUserDefaultsRenderType];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

static NSString *ZHUserDefaultsRenderGrid = @"ZHUserDefaultsRenderGrid";
+(BOOL)renderGrid{
//    return [[NSUserDefaults standardUserDefaults] boolForKey:ZHUserDefaultsRenderGrid];
    return YES;
}

+(void)setRenderGrid:(BOOL)renderGrid{
    [[NSUserDefaults standardUserDefaults] setBool:renderGrid forKey:ZHUserDefaultsRenderGrid];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
