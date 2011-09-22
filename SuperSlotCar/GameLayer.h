//
//  GameLayer.h
//  SuperSlotCar
//
//  Created by John Wilson on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class LevelLayer;
@class GameUILayer;
@class BackgroundLayer;
@class RaceOverLayer;
@interface GameLayer : CCLayer {
    LevelLayer *levelLayer;
    GameUILayer *gameUILayer;
    BackgroundLayer *backgroundLayer;
    RaceOverLayer *raceOverLayer;
    
}



@end
