//
//  GameLayer.m
//  SuperSlotCar
//
//  Created by John Wilson on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "GameUILayer.h"
#import "LevelLayer.h"
#import "LevelModel.h"
#import "BackgroundLayer.h"
#import "RaceOverLayer.h"

@implementation GameLayer


-(id) init	
{
	
	if( (self=[super init])) {
        LevelModel *LM = [LevelModel sharedInstance];
        
        //create the layers
        
        backgroundLayer = [BackgroundLayer node];
        LM.backgroundLayer = backgroundLayer;
        

        levelLayer =  [LevelLayer node];
        LM.levelLayer = levelLayer;
        
        gameUILayer = [GameUILayer node];
        LM.gameUILayer = gameUILayer;
        
        raceOverLayer = [RaceOverLayer node];
        LM.raceOverLayer = raceOverLayer;
        
        [self addChild:backgroundLayer z:0 tag:0];
        [self addChild:levelLayer z:1 tag:1];
        [self addChild:gameUILayer z:2 tag:2];
//        [self addChild:raceOverLayer z:3 tag:3];
        
        
        //resolve start
        [backgroundLayer resolve];
        [levelLayer resolve];


    }
    return self;
}

-(void) dealloc{
    [super dealloc];	
}

@end
