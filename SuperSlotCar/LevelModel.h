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
@interface LevelModel : NSObject{
    
    
    TrackVO *trackVO;
    
    CarSprite *playerCar;

    
    //touch state
    BOOL isTouching;
    CGPoint touchBegan;
    CGPoint previousTouch;
    CGPoint currentTouch;
    CGPoint touchEnd;

    
    //gameLayers
    GameUILayer *gameUILayer;
    LevelLayer *levelLayer;
    GameLayer *gameLayer;
    BackgroundLayer *backgroundLayer;
    

}

@property (nonatomic, retain) CarSprite *playerCar;
@property (nonatomic, retain) TrackVO *trackVO;
@property BOOL isTouching;
@property CGPoint touchBegan, previousTouch, currentTouch, touchEnd;

// gameLayers
@property (nonatomic, retain) GameUILayer *gameUILayer;
@property (nonatomic, retain) LevelLayer *levelLayer;
@property (nonatomic, retain) GameLayer *gameLayer;
@property (nonatomic, retain) BackgroundLayer *backgroundLayer;


+ (id)sharedInstance;

@end
