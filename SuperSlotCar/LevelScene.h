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
@interface LevelScene  : CCScene {
    //Layers
    LevelLayer *levelLayer;
    GameLayer *gameLayer;
    //UI should have its own layer here
    
    
}

@property (nonatomic, retain) LevelLayer *levelLayer;
@property (nonatomic, retain) GameLayer *gameLayer;


-(id) init;
-(void)dealloc;

-(void)gameLoop:(ccTime)dt;

@end
