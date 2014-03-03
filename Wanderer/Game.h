//
//  Game.h
//  Wanderer
//
//  Created by M. Ramón López Torres on 08/12/13.
//  Copyright (c) 2013 M. Ramón López Torres (ATC). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject {
    // Internal vars
    NSInteger player1ID;
    NSInteger player2ID;
    
    // Properties
    NSInteger _gameID;
    NSInteger _myPlayerNumber;
    NSInteger _yourPlayerNumber;
    NSInteger _activePlayerNumber;
    NSArray *_myBalls;
    NSArray *_yourBalls;
    NSArray *_lastMovement;
}

@property (nonatomic, readonly) NSInteger gameID;
@property (nonatomic, readonly) NSInteger myPlayerNumber;
@property (nonatomic, readonly) NSInteger yourPlayerNumber;
@property (nonatomic, readonly) NSInteger activePlayerNumber;
@property (nonatomic, readonly) NSArray *myBalls;
@property (nonatomic, readonly) NSArray *yourBalls;
@property (nonatomic, readonly) NSArray *lastMovement;

// Public method
-(BOOL)isMyTurn;
-(BOOL)checkVictoryOfActivePlayer;
-(BOOL)send;
-(void)load;
@end
