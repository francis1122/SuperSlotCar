//
//  LevelScene.m
//  SuperSlotCar
//
//  Created by Hunter Francis on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelScene.h"
#import "GameLayer.h"
#import "LevelModel.h"
#import "LevelController.h"
#import "RaceOverLayer.h"

@implementation LevelScene

@synthesize gameLayer;


-(id) init{
	
	if( (self=[super init])) {

		[self schedule: @selector(gameLoop:)];
        
        LevelModel *LM = [LevelModel sharedInstance];
        
        self.gameLayer = [GameLayer node];
        LM.gameLayer = self.gameLayer;
        
        
        [self addChild:self.gameLayer];
	}
	return self;
}

-(void)dealloc{
    [gameLayer release];
	[super dealloc];
}

-(void) gameLoop:(ccTime) dt{
    LevelModel *LM = [LevelModel sharedInstance];
    
    //game logic
    if(LM.levelLayer){
        [LevelController update:dt];
    }
}
    
@end
