//
//  GameUILayer.m
//  SuperSlotCar
//
//  Created by John Wilson on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameUILayer.h"
#import "LevelModel.h"
#import "CarSprite.h"
#import "TrackVO.h"


@implementation GameUILayer






#pragma -
#pragma draw
-(void) draw{
    [super draw];
    //    BezierCurve *carCurve = [self.trackVO.trackPoints objectAtIndex:self.carPosition.index];
    
    //  CGPoint carSpot = [BezierCurve findPositionOnCurve:carCurve atTime:self.carPosition.time];
    LevelModel *LM = [LevelModel sharedInstance];

    //draw health bar
    float line = LM.playerCar.health* 10;
    //        float line = 500/5;
    ccDrawLine(ccp(20,  20), ccp( 20 + line, 20));
    
}



@end

