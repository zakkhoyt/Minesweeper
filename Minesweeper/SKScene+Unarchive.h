//
//  SKScene+Unarchive.h
//  Minesweeper
//
//  Created by Zakk Hoyt on 10/29/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKScene (Unarchive)
+ (instancetype)unarchiveFromFile:(NSString *)file;
@end
