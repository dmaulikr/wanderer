//
//  ViewController.m
//  Wanderer
//
//  Created by M. Ramón López Torres (ATC) on 21/11/13.
//  Copyright (c) 2013 M. Ramón López Torres (ATC). All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    game = [[Game alloc] init];
    
    CGSize size = self.view.frame.size;
    CGRect rect = CGRectMake(0, (size.height-size.width)/2, size.width, size.width);
    board = [[WandererBoard alloc] initWithFrame:rect];
    board.game = game;
    
    if (game.activePlayerNumber==1) {
        infoLabel.text = @"Jugador azul";
    } else {
        infoLabel.text = @"Jugador verde";
    }
    
    [self.view addSubview:board];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)play:(id)sender {
    if ([game checkVictoryOfActivePlayer]) {
        NSString *mensage;
        
        if (game.activePlayerNumber==1) {
            mensage = @"Jugador azul gana!!!";
        } else {
            mensage = @"Jugador verde gana!!!";
        }

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Test" message:mensage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
        game = [[Game alloc] init];
        board.game = game;
    } else if([game send]) {
        [board initTurn];
    }
    
    if (game.activePlayerNumber==1) {
        infoLabel.text = @"Jugador azul";
    } else {
        infoLabel.text = @"Jugador verde";
    }
}

- (IBAction)reset:(id)sender {
    [board resetPosition];
}

@end
