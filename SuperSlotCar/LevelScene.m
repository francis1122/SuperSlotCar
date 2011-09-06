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


@implementation LevelScene

@synthesize levelLayer, gameLayer;


-(id) init{
	
	if( (self=[super init])) {

		[self schedule: @selector(gameLoop:)];
        
        LevelModel *LM = [LevelModel sharedInstance];
        GameLayer *gL = [GameLayer node];
        self.gameLayer = gL;
        LM.gameLayer = gL;
        
        
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

   // [self.levelLayer update:dt];
}
    
@end
