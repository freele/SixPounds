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
    CCSprite *_img;
    id _actionSeq;
}

- (void) didLoadFromCCB{
    NSLog(@"init player");
    
    
    _direction = -1;
    _speed = 100;
    [self flip];
    
}


- (void) flip{
    NSLog(@"flip");
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
    NSLog(@"fire");
    
}

@end
