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
    
    CCNode *_flipInput;
    CCNode *_fireInput;
    
    float _spawnBasePause;
}

- (void) didLoadFromCCB{
    self.userInteractionEnabled = TRUE;
    self.multipleTouchEnabled = TRUE;
    
    _pauseScreen.zOrder = 100;
    
    _spawnBasePause = 3.0;
    id actionDelay = [CCActionDelay actionWithDuration:3];
    id actionSpawn = [CCActionCallFunc actionWithTarget:self selector:@selector(spawnDrone)];
    id actionSeq = [CCActionSequence actions:actionDelay, actionSpawn, nil];
    [self runAction: actionSeq];
    
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
//    NSLog(@"Flip Button Pressed");
    // we want to know the location of our touch in this scene
    CGPoint touchLocation = [touch locationInNode:_flipInput];

    if (touchLocation.x < _flipInput.contentSize.width &&
        touchLocation.y < _flipInput.contentSize.height &&
        touchLocation.x > 0 &&
        touchLocation.y > 0){
        NSLog(@"_flipInput");
        [self playerFlip];
    }
    
    touchLocation = [touch locationInNode:_fireInput];
    if (touchLocation.x < _fireInput.contentSize.width &&
        touchLocation.y < _fireInput.contentSize.height &&
        touchLocation.x > 0 &&
        touchLocation.y > 0){
        NSLog(@"_fireInput");
        [self playerFire];
    }
    
}


- (void) spawnDrone{
//    NSLog(@"spawnDrone");
    
    __block CCNode *drone = [CCBReader load:@"ccbResources/entities/npc/drone"];
    float droneHeight = 0.7;
    drone.position = ccp(-drone.contentSize.width, droneHeight*self.parent.contentSize.height);
    CGPoint finalPoint = ccp(self.parent.contentSize.width, droneHeight*self.parent.contentSize.height);
    id actionDroneMove = [CCActionMoveTo actionWithDuration:3
                                                   position:finalPoint];
    id actionDroneRemove = [CCActionCallBlock actionWithBlock:^{
        [self removeChild:drone];
        drone = nil;
    }];
    id actionDroneSeq = [CCActionSequence actions:actionDroneMove, actionDroneRemove, nil];
    [drone runAction:actionDroneSeq];
    [self addChild:drone];
    
    
    float delay = _spawnBasePause * (0.5 + 0.5*(float)rand()/RAND_MAX);
    id actionDelay = [CCActionDelay actionWithDuration:delay];
    id actionSpawn = [CCActionCallFunc actionWithTarget:self selector:@selector(spawnDrone)];
    
    id actionSeq = [CCActionSequence actions:actionDelay, actionSpawn, nil];
    [self runAction: actionSeq];
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
