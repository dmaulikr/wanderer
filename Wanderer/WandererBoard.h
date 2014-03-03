//
//  WandererBoard.h
//  Wanderer
//
//  Created by M. Ramón López Torres (ATC) on 21/11/13.
//  Copyright (c) 2013 M. Ramón López Torres (ATC). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

#define NONE_MOVEMENT 0
#define HORIZONTAL_MOVEMENT 1
#define VERTICAL_MOVEMENT 2

@interface WandererBoard : UIControl {
    // Internal vars
    NSInteger stepX, stepY;
    NSInteger left, right, top, bottom;
    CGFloat movingX, movingY;
    CGFloat maxX, minX, maxY, minY;
    NSInteger movementOrientation;
    NSArray *myBalls;
    NSArray *yourBalls;
    NSArray *balls;
    
    NSInteger oldI;
    NSInteger oldJ;
    NSInteger activeBall;
    BOOL ballIsMoving;
    
    // Properties
    Game *_game;
}

@property (nonatomic, retain) Game *game;

// Public method
-(void)resetPosition;
-(void)initTurn;

@end
