//
//  ZHUserDefaults.h
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/30/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZHUserDefaults : NSObject


+(NSUInteger)boardWidth;
+(void)setBoardWidth:(NSUInteger)boardWidth;

+(NSUInteger)mineCount;
+(void)setMineCount:(NSUInteger)mineCount;

+(NSUInteger)renderType;
+(void)setRenderType:(NSUInteger)renderType;

@end
