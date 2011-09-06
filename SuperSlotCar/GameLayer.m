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

@implementation GameLayer

//@synthesize gameUILayer, levelLayer;

-(id) init	
{
	
	if( (self=[super init])) {
        LevelModel *LM = [LevelModel sharedInstance];
        
        //create the layers
        
        BackgroundLayer *bL = [BackgroundLayer node];
        backgroundLayer = bL;
        
        LevelLayer *lL = [LevelLayer node];
        levelLayer = lL;
        LM.levelLayer = lL;
        
        GameUILayer *gUL = [GameUILayer node];
        gameUILayer = gUL;
        LM.gameUILayer = gUL;
        

        
        
        [self addChild:backgroundLayer];
        [self addChild:gameUILayer];
        [self addChild:levelLayer];
        
        
        //resolve starte
        [backgroundLayer resolve];


    }
    return self;
}

-(void) dealloc{
    [gameUILayer release];
    [levelLayer release];
    [super dealloc];	
}

@end
