//
//  LevelModel.h
//  SuperSlotCar
//
//  Created by John Wilson on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@class TrackVO;
@class BezierCurve;
@class CarSprite;
@class GameLayer;
@class LevelLayer;
@class GameUILayer;
@class BackgroundLayer;
@class RaceOverLayer;
@interface LevelModel : NSObject{
    
    
    TrackVO *trackVO;
    
    CarSprite *playerCar;
    
    //touch state
    BOOL isTouching;
    CGPoint touchBegan;
    CGPoint previousTouch;
    CGPoint currentTouch;
    CGPoint touchEnd;

    BOOL raceInProgress;
    BOOL isCountDownToRaceStarted;
    float countDownToRaceStart;
    float raceTime;
    BOOL isRaceOver;
    
    //gameLayers

    GameLayer *gameLayer;
    RaceOverLayer *raceOverLayer;
    LevelLayer *levelLayer;
    GameUILayer *gameUILayer;
    BackgroundLayer *backgroundLayer;
    

}

@property float raceTime, countDownToRaceStart;
@property (nonatomic, retain) CarSprite *playerCar;
@property (nonatomic, retain) TrackVO *trackVO;
@property BOOL isTouching, raceInProgress, isCountDownToRaceStarted, isRaceOver;
@property CGPoint touchBegan, previousTouch, currentTouch, touchEnd;

// gameLayers
@property (nonatomic, retain) GameLayer *gameLayer;
@property (nonatomic, retain) RaceOverLayer *raceOverLayer;
@property (nonatomic, retain) GameUILayer *gameUILayer;
@property (nonatomic, retain) LevelLayer *levelLayer;
@property (nonatomic, retain) BackgroundLayer *backgroundLayer;


+ (id)sharedInstance;

//clears all variables
-(void) reset;

@end
