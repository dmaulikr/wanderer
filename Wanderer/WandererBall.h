//
//  WandererBall.h
//  Wanderer
//
//  Created by M. Ramón López Torres on 21/11/13.
//  Copyright (c) 2013 M. Ramón López Torres (ATC). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WandererBall : NSObject {
    NSInteger i, j;
    CGPoint postion;
    NSUInteger player;
}

@property NSInteger i;
@property NSInteger j;
@property CGPoint position;
@property NSUInteger player;

-(id)initWithPlayer:(NSUInteger)_player col:(NSUInteger)col row:(NSUInteger)row;

@end
