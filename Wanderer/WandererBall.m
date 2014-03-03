//
//  WandererBall.m
//  Wanderer
//
//  Created by M. Ramón López Torres on 21/11/13.
//  Copyright (c) 2013 M. Ramón López Torres (ATC). All rights reserved.
//

#import "WandererBall.h"

@implementation WandererBall
@synthesize i, j, player;


-(id)initWithPlayer:(NSUInteger)_player col:(NSUInteger)col row:(NSUInteger)row {
    self.i = col;
    self.j = row;
    self.player = _player;
    
    return self;
}

@end
