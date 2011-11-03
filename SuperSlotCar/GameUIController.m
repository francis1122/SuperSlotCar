//
//  GameUIController.m
//  SuperSlotCar
//
//  Created by John Wilson on 10/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameUIController.h"
#import "LevelScene.h"
#import "LevelLayer.h"
#import "TrackVO.h"
#import "CarSprite.h"
#import "RaceOverLayer.h"
#import "LevelModel.h"
#import "RaceOverLayer.h"
#import "GameUILayer.h"

@implementation GameUIController

+(void) update:(ccTime)dt{
    LevelModel *LM = [LevelModel sharedInstance];
    GameUILayer *GUIL = LM.gameUILayer;
    [GameUIController refreshLapCountLabel:GUIL.lapCountLabel forCar:LM.playerCar];
    
}

+(void) refreshLapCountLabel:(CCLabelTTF*) label forCar:(CarSprite*) car{
    if(car.isNewLap){
        [label setString:[NSString stringWithFormat:@"lap %d", car.currentLap]];
        car.isNewLap = NO;
    }
    
}

@end
