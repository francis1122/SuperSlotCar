//
//  LevelScene.h
//  SuperSlotCar
//
//  Created by Hunter Francis on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class LevelLayer;
@class GameLayer;
@class RaceOverLayer;
@interface LevelScene  : CCScene {
    GameLayer *gameLayer;
    RaceOverLayer *raceOverLayer;
    
    //UI should have its own layer here
    
    
}

@property (nonatomic, retain) GameLayer *gameLayer;
@property (nonatomic, retain) RaceOverLayer *raceOverLayer;


-(id) init;
-(void)dealloc;

-(void)gameLoop:(ccTime)dt;

@end
