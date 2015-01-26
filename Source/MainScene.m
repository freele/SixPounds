#import "MainScene.h"

@implementation MainScene

- (void) play{
    NSLog(@"play");
    [[CCDirector sharedDirector] pushScene: [CCBReader loadAsScene:@"Border"]];
    
}

@end
