//
//  main.m
//  Wanderer
//
//  Created by M. Ramón López Torres (ATC) on 21/11/13.
//  Copyright (c) 2013 M. Ramón López Torres (ATC). All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
#ifdef ANDROID
        [UIScreen mainScreen].currentMode =
        [UIScreenMode emulatedMode:UIScreenIPhone3GEmulationMode];
#endif
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
