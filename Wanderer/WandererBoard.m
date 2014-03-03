    //
//  WandererBoard.m
//  Wanderer
//
//  Created by M. Ramón López Torres (ATC) on 21/11/13.
//  Copyright (c) 2013 M. Ramón López Torres (ATC). All rights reserved.
//

#import "WandererBoard.h"
#import "WandererBall.h"

@implementation WandererBoard

-(void)setGame:(Game *)newGame {
    _game = newGame;
    balls = [NSArray arrayWithArray:[_game.myBalls arrayByAddingObjectsFromArray:_game.yourBalls]];
    [self initTurn];
}

-(Game *)game {
    return _game;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        stepX = frame.size.width / SIDE_SIZE;
        stepY = frame.size.height / SIDE_SIZE;
        
        left = (frame.size.width - stepX*(SIDE_SIZE-1))/2;
		right = left + stepX*(SIDE_SIZE-1);
        
		bottom = (frame.size.height - stepY*(SIDE_SIZE-1))/2;;
		top = bottom + stepY*(SIDE_SIZE-1);
        
        movingX = left;
        movingY = bottom;
        
        ballIsMoving = FALSE;
        activeBall = -1;
        movementOrientation = NONE_MOVEMENT;
        
        
        myBalls = [[NSArray alloc] initWithObjects:
                    [[WandererBall alloc] initWithPlayer:1 col:1 row:2],
                    [[WandererBall alloc] initWithPlayer:1 col:SIDE_SIZE-3 row:1],
                    [[WandererBall alloc] initWithPlayer:1 col:2 row:SIDE_SIZE-2],
                    [[WandererBall alloc] initWithPlayer:1 col:SIDE_SIZE-2 row:SIDE_SIZE-3],
                    nil];
        yourBalls = [[NSArray alloc] initWithObjects:
                      [[WandererBall alloc] initWithPlayer:2 col:2 row:1],
                      [[WandererBall alloc] initWithPlayer:2 col:SIDE_SIZE-2 row:2],
                      [[WandererBall alloc] initWithPlayer:2 col:1 row:SIDE_SIZE-3],
                      [[WandererBall alloc] initWithPlayer:2 col:SIDE_SIZE-3 row:SIDE_SIZE-2],
                      nil];
        
        balls = [NSArray arrayWithArray:[myBalls arrayByAddingObjectsFromArray:yourBalls]];

    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    CGContextSetLineWidth(context, 2.0);
    
    // Lineas
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    // Verticales
	NSInteger x = left;
	for (int i=0; i<SIDE_SIZE; i++) {
        CGContextMoveToPoint(context, x, top);
        CGContextAddLineToPoint(context, x, bottom);
			
		x+=stepX;
	}
	
    // Horizonales
	NSInteger y = bottom;
    for (int j=0; j<SIDE_SIZE; j++) {
        CGContextMoveToPoint(context, left, y);
        CGContextAddLineToPoint(context, right, y);
        y+=stepY;
	}
    CGContextStrokePath(context);
    
    // Circulos
    CGContextSetLineWidth(context, 2.0);
    for (WandererBall *ball in balls) {
        CGRect borderRect;
    
        if (ball.player==1) {
            CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
            CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
        } else {
            CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 1.0);
            CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
        }
        
        if ([balls indexOfObject:ball] == activeBall) {
            CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
        }
        
        if ([balls indexOfObject:ball] == activeBall && ballIsMoving) {
            borderRect = CGRectMake(movingX-stepX/4, movingY-stepY/4, stepX/2, stepY/2);
        } else {
            borderRect = CGRectMake(left+ball.i*stepX -stepX/4, bottom+ball.j*stepY-stepY/4, stepX/2, stepY/2);
        }
        
        CGContextFillEllipseInRect (context, borderRect);
        CGContextStrokeEllipseInRect(context, borderRect);
        CGContextFillPath(context);
    }
    /*
    CGRect borderRect = CGRectMake(movingX-stepX/4, movingY-stepY/4, stepX/2, stepY/2);
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 2.0);
    CGContextFillEllipseInRect (context, borderRect);
    CGContextStrokeEllipseInRect(context, borderRect);
    CGContextFillPath(context);*/
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // Choose one of the touches to work with
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self];
    
    [self initBallMovementAt:location];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self];
    
    if (ballIsMoving) {
        switch (movementOrientation) {
            case HORIZONTAL_MOVEMENT:
                if (location.x>=minX && location.x<=maxX) {
                    movingX = location.x;
                }
                break;
            case VERTICAL_MOVEMENT:
                if (location.y>=minY && location.y<=maxY) {
                    movingY = location.y;
                }
                break;
            default:
            {
                // No sabemos aún que dirección va a tomar
                CGFloat distance = sqrtf(pow(movingX-location.x,2)+pow(movingY-location.y,2));
                
                if (distance>stepX/2) {
                    if (abs(movingX-location.x)>abs(movingY-location.y)) {
                        movementOrientation = HORIZONTAL_MOVEMENT;
                    } else if (abs(movingX-location.x)<abs(movingY-location.y)) {
                        movementOrientation = VERTICAL_MOVEMENT;
                    }
                }
                break;
            }
               
        }
        
        [self setNeedsDisplay];
    } else {
        [self initBallMovementAt:location];
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (ballIsMoving) {
        WandererBall *ball = [balls objectAtIndex:activeBall];
        
        switch (movementOrientation) {
            case HORIZONTAL_MOVEMENT:
                ball.i = round((movingX-left)/stepX);
                if (ball.i<0) {
                    ball.i = 0;
                } else if (ball.i>=SIDE_SIZE) {
                    ball.i=SIDE_SIZE-1;
                }
                [self setNeedsDisplay];
                NSLog(@"(%lf, %lf)", movingX, movingY);
                break;
            case VERTICAL_MOVEMENT:
                ball.j = round((movingY-bottom)/stepY);
                if (ball.j<0) {
                    ball.j = 0;
                } else if (ball.j>=SIDE_SIZE) {
                    ball.j=SIDE_SIZE-1;
                }
                [self setNeedsDisplay];
                NSLog(@"(%lf, %lf)", movingX, movingY);
                break;
        }
        
        ballIsMoving = FALSE;
        movementOrientation = NONE_MOVEMENT;
        [self setNeedsDisplay];
    }
    
}

- (void)calculeLimitsForBall:(WandererBall *)ball {
    if (ballIsMoving) {
        NSInteger maxI = SIDE_SIZE;
        NSInteger minI = -1;
        NSInteger maxJ = SIDE_SIZE;
        NSInteger minJ = -1;
        
        // Buscamos los topes de movimiento producidos por otras bolas
        for (WandererBall *otherBall in balls) {
            if ([balls indexOfObject:otherBall] != activeBall) {
                if (ball.i == otherBall.i) {
                    if (otherBall.j>ball.j && otherBall.j<maxJ) {
                        maxJ = otherBall.j;
                    }
                    if (otherBall.j<ball.j && otherBall.j>minJ) {
                        minJ = otherBall.j;
                    }
                } else if (ball.j == otherBall.j) {
                    if (otherBall.i>ball.i && otherBall.i<maxI) {
                        maxI = otherBall.i;
                    }
                    if (otherBall.i<ball.i && otherBall.i>minI) {
                        minI = otherBall.i;
                    }
                }
            }
        }
        maxX = left + (maxI-1)*stepX;
        minX = left + (minI+1)*stepX;
        maxY = bottom + (maxJ-1)*stepY;
        minY = bottom + (minJ+1)*stepY;
    }
}

- (void)initBallMovementAt:(CGPoint)pos {
    if (activeBall>=0) {
        WandererBall *ball = [balls objectAtIndex:activeBall];
        CGFloat x = ball.i * stepX + left;
        CGFloat y = ball.j * stepY + bottom;
        CGFloat distance = sqrtf(pow(x-pos.x,2)+pow(y-pos.y,2));
        
        if(distance<=stepX/2 && ball.player==_game.activePlayerNumber) {
            ballIsMoving = TRUE;
            movingX = left+ball.i*stepX;
            movingY = bottom+ball.j*stepY;
            
            [self calculeLimitsForBall:ball];
        }
    } else {
        for (NSInteger i=0; i<8 && activeBall<0; i++) {
            WandererBall *ball = [balls objectAtIndex:i];
            CGFloat x = ball.i * stepX + left;
            CGFloat y = ball.j * stepY + bottom;
            CGFloat distance = sqrtf(pow(x-pos.x,2)+pow(y-pos.y,2));
            
            if(distance<=stepX/2 && ball.player==_game.activePlayerNumber) {
                activeBall = i;
                ballIsMoving = TRUE;
                movingX = left+ball.i*stepX;
                movingY = bottom+ball.j*stepY;
                oldI = ball.i;
                oldJ = ball.j;
                [self calculeLimitsForBall:ball];

            }
        }
    }
}

#pragma mark - Public Method
-(void)resetPosition {
    if (activeBall>=0) {
        WandererBall *ball = [balls objectAtIndex:activeBall];
        ball.i = oldI;
        ball.j = oldJ;
        activeBall = -1;
        ballIsMoving = FALSE;
        [self setNeedsDisplay];
    }
}

-(void)initTurn {
    activeBall = -1;
    ballIsMoving = FALSE;
    [self setNeedsDisplay];
}
@end
