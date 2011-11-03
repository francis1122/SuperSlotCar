//
//  LevelModel.m
//  SuperSlotCar
//
//  Created by John Wilson on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelModel.h"

static LevelModel *sharedInstance = nil;

@implementation LevelModel

@synthesize trackVO, playerCar, isTouching, touchBegan, previousTouch, currentTouch, touchEnd,
gameLayer, gameUILayer, levelLayer, backgroundLayer, raceTime, raceInProgress, countDownToRaceStart,
isCountDownToRaceStarted, raceOverLayer, isRaceOver;

+ (id)sharedInstance{ 
    @synchronized(self){
        if(sharedInstance == nil)
            sharedInstance = [[[self class] alloc] init];
    }
    return sharedInstance;
}


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.raceTime = 0.0f;
        self.countDownToRaceStart = 0.0f;
        self.raceInProgress = NO;
        self.isCountDownToRaceStarted = NO;
        self.isRaceOver = NO;
    }
    
    return self;
}

-(void) reset{
    
    // Initialization code here.
    self.raceTime = 0.0f;
    self.countDownToRaceStart = 0.0f;
    self.raceInProgress = NO;
    self.isCountDownToRaceStarted = NO;
    self.isRaceOver = NO;
    
    self.playerCar = NULL;
    self.trackVO = NULL;
    self.isTouching = NO;
    self.raceInProgress = NO;
    self.isCountDownToRaceStarted = NO;
    self.isRaceOver = NO;
    self.gameLayer = NULL;
    self.raceOverLayer = NULL;
    self.gameUILayer = NULL;
    self.levelLayer = NULL;
    self.backgroundLayer = NULL;
    
}

-(void) dealloc{
    
    //need to release every retained property
    
    [super dealloc];	
}

@end
