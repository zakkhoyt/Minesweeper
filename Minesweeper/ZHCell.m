//
//  ZHCell.m
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/29/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import "ZHCell.h"

@implementation ZHCell

+(NSString*)keyFromX:(NSUInteger)x Y:(NSUInteger)y{
    return [NSString stringWithFormat:@"x%lu:y%lu", (unsigned long)x, (unsigned long)y];
}

- (instancetype)initWithX:(NSUInteger)x Y:(NSUInteger)y {
    self = [super init];
    if (self) {
        _x = x;
        _y = y;
    }
    return self;
}

-(NSString*)key{
    return [NSString stringWithFormat:@"x%lu:y%lu", (unsigned long)_x, (unsigned long)_y];
}

#pragma mark Private methods


#pragma mark Private NSObject overrides

-(BOOL)isEqual:(id)object{
    if([object isKindOfClass:[self class]] == NO ) {
        return NO;
    }
    return ((ZHCell*)object).hash == self.hash;
}

-(NSUInteger)hash {
    return self.key.hash;
}

@end
