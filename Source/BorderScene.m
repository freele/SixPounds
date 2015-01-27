//
//  BorderScene.m
//  SixPounds
//
//  Created by Alexander Kremenets on 26/01/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "BorderScene.h"
#import "Player.h"

@implementation BorderScene{
    CCNode *_pauseScreen;
    Player *_player;
}

- (void) pause{
    NSLog(@"pause");
    [[CCDirector sharedDirector] pause];
    _pauseScreen.visible = true;
    
}

- (void) resume{
    NSLog(@"resume");
    [[CCDirector sharedDirector] resume];
    _pauseScreen.visible = false;
    
}

- (void) exit{
    NSLog(@"exit");
    [[CCDirector sharedDirector] popScene];
}

- (void) playerFlip{
    [_player flip];
}

- (void) playerFire{
    [_player fire];
}
@end
