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
    glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
    if(LM.playerCar.isCoolingDown){
        glColor4f(1.0f, 0.0f, 0.0f, 1.0f);
    }
    float line = LM.playerCar.health* 15;
    //        float line = 500/5;
    ccDrawLine(ccp(20,  20), ccp( 20 + line, 20));
    
    glColor4f(1, 1, 1, 1);
    //speedLine
    float speed = LM.playerCar.boost/10;
    ccDrawLine(ccp(20, 20), ccp(20, 20 + speed));
}



@end

