//
//  Game.m
//  Wanderer
//
//  Created by M. Ramón López Torres on 08/12/13.
//  Copyright (c) 2013 M. Ramón López Torres (ATC). All rights reserved.
//

#import "Game.h"
#import "WandererBall.h"

@implementation Game
@synthesize gameID = _gameID;
@synthesize myPlayerNumber = _myPlayerNumber, myBalls = _myBalls;
@synthesize yourPlayerNumber = _yourPlayerNumber, yourBalls = _yourBalls;
@synthesize lastMovement = _lastMovement;
@synthesize activePlayerNumber = _activePlayerNumber;



-(id)init {
    player1ID = 0;
    player2ID = 0;
    
    _gameID = 0;
    _myPlayerNumber = 0;
    _yourPlayerNumber = 0;
    _activePlayerNumber = 1;
    _myBalls = [[NSArray alloc] initWithObjects:
               [[WandererBall alloc] initWithPlayer:1 col:1 row:2],
               [[WandererBall alloc] initWithPlayer:1 col:SIDE_SIZE-3 row:1],
               [[WandererBall alloc] initWithPlayer:1 col:2 row:SIDE_SIZE-2],
               [[WandererBall alloc] initWithPlayer:1 col:SIDE_SIZE-2 row:SIDE_SIZE-3],
               nil];
    _yourBalls = [[NSArray alloc] initWithObjects:
                [[WandererBall alloc] initWithPlayer:2 col:2 row:1],
                [[WandererBall alloc] initWithPlayer:2 col:SIDE_SIZE-2 row:2],
                [[WandererBall alloc] initWithPlayer:2 col:1 row:SIDE_SIZE-3],
                [[WandererBall alloc] initWithPlayer:2 col:SIDE_SIZE-3 row:SIDE_SIZE-2],
                nil];
    _lastMovement = nil;
    
    return self;
}

-(BOOL)checkVictoryOfActivePlayer {
    NSArray *balls;
    if (_activePlayerNumber == 1) {
        balls = [NSArray arrayWithArray:_myBalls];
    } else {
        balls = [NSArray arrayWithArray:_yourBalls];
    }
    
    // Ordeno las bolas, primero por la I y luego por la J
    NSInteger order[4] = {0, 1, 2, 3};
    
    for(NSInteger i=0;i<3;i++) {
        for (NSInteger j=i+1; j<4; j++) {
            WandererBall *minor = [balls objectAtIndex:order[i]];
            WandererBall *current = [balls objectAtIndex:order[j]];
            if (minor.i > current.i || (minor.i == current.i && minor.j > current.j)) {
                NSInteger aux = order[i];
                order[i] = order[j];
                order[j] = aux;
            }
        }
    }
    
    WandererBall *n0= [balls objectAtIndex:order[0]];
    WandererBall *n1 = [balls objectAtIndex:order[1]];
    WandererBall *n2= [balls objectAtIndex:order[2]];
    WandererBall *n3 = [balls objectAtIndex:order[3]];
    NSLog(@"(%d, %d) (%d, %d) (%d, %d) (%d, %d) ", n0.i, n0.j, n1.i, n1.j, n2.i, n2.j, n3.i, n3.j);
    
    if (
        // Horizontal
        ((n1.i-n0.i==1 && n1.j-n0.j==0) &&
        (n2.i-n1.i==1 && n2.j-n1.j==0) &&
        (n3.i-n2.i==1 && n3.j-n2.j==0))
        ||
        // Vertical
        ((n1.i-n0.i==0 && n1.j-n0.j==1) &&
        (n2.i-n1.i==0 && n2.j-n1.j==1) &&
        (n3.i-n2.i==0 && n3.j-n2.j==1))
        ||
        //Diagonal
        ((abs(n1.i-n0.i)==1 && abs(n1.j-n0.j)==1) &&
        (abs(n2.i-n1.i)==1 && abs(n2.j-n1.j)==1) &&
        (abs(n3.i-n2.i)==1 && abs(n3.j-n2.j)==1))
        ) {
        return TRUE;
    }
    
    return FALSE;
}

-(BOOL)isMyTurn {
    return (player1ID==myUserID && _activePlayerNumber==1) || (player2ID==myUserID && _activePlayerNumber==2);
}

-(BOOL)send {
    _activePlayerNumber = _activePlayerNumber==1?2:1;
    return TRUE;
}
-(void)load {
    
}


@end
