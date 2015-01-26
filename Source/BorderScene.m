//
//  BorderScene.m
//  SixPounds
//
//  Created by Alexander Kremenets on 26/01/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "BorderScene.h"

@implementation BorderScene{
    CCNode *_pauseScreen;
}

- (void) pause{
    NSLog(@"pause");
    _pauseScreen.visible = true;
    
}

- (void) resume{
    NSLog(@"resume");
    _pauseScreen.visible = false;
    
}

- (void) exit{
    NSLog(@"exit");
    [[CCDirector sharedDirector] popScene];
}
@end
