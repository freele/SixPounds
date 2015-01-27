//
//  Player.m
//  SixPounds
//
//  Created by Alexander Kremenets on 27/01/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Player.h"

@implementation Player{
    int _direction;
    float _speed;
    
    CCNode *_bulletSpawnPoint;
    CCNode *_bulletSpawnPointFlipped;
    
    CCSprite *_img;
    id _actionSeq;
}

- (void) didLoadFromCCB{
//    NSLog(@"init player");
    
    
    _direction = -1;
    _speed = 100.0;
    [self flip];
}

- (void) flip{
//    NSLog(@"flip");
    _direction *= -1;
    CGPoint finalPoint;
    
    
    float rightBorder = self.parent.contentSize.width - self.contentSize.width;
    float pathLength;
    if (_direction > 0){
        _img.flipX = false;
        pathLength = rightBorder - self.position.x;
        finalPoint = ccp(self.parent.contentSize.width - self.contentSize.width, self.position.y);
        
    } else {
        _img.flipX = true;
        pathLength = self.position.x;
        finalPoint = ccp(0, self.position.y);
    }
    float time = pathLength / _speed;
    
    id actionMove = [CCActionMoveTo actionWithDuration:time position:finalPoint];
    id actionFunc = [CCActionCallFunc actionWithTarget:self selector:@selector(flip)];
    
    
    if (_actionSeq){
        [self stopAction: _actionSeq];
    }
    _actionSeq = [CCActionSequence actions:actionMove, actionFunc, nil];
    [self runAction: _actionSeq];
}

- (void) fire{
//    NSLog(@"fire");
    [self spawnBullet];

}

- (void) spawnBullet{
    __block CCNode *bullet = [CCBReader load:@"ccbResources/entities/bullet"];

    CGPoint spawnPoint = _direction > 0 ? _bulletSpawnPoint.position : _bulletSpawnPointFlipped.position;
    bullet.position = [self convertToWorldSpace: spawnPoint];
    CGPoint finalPoint = ccp(bullet.position.x + 300 * _direction, self.scene.contentSize.height);
    id actionBulletMove = [CCActionMoveTo actionWithDuration:1.5
                                                   position:finalPoint];
    id actionBulletRemove = [CCActionCallBlock actionWithBlock:^{
        [self.parent removeChild:bullet];
        bullet = nil;
    }];
    id actionDroneSeq = [CCActionSequence actions:actionBulletMove, actionBulletRemove, nil];
    [bullet runAction:actionDroneSeq];
    [self.parent addChild:bullet];

}

@end
