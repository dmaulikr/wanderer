//
//  ViewController.h
//  Wanderer
//
//  Created by M. Ramón López Torres (ATC) on 21/11/13.
//  Copyright (c) 2013 M. Ramón López Torres (ATC). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WandererBoard.h"
#import "Game.h"

@interface ViewController : UIViewController {
    WandererBoard *board;
    Game *game;
    
    IBOutlet UILabel *infoLabel;
}

@end
