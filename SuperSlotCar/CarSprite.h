//
//  CarSprite.h
//  SuperSlotCar
//
//  Created by Hunter Francis on 8/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CarSprite : CCSprite {
    
    CurvePosition *carTrackPosition;
    
    //is YES when health gets to high
    BOOL isCoolingDown;

    //how long entity has been alive for
    float lifeTime;
    
    CGPoint previousPosition;
    CGPoint previousVelocity;
    CGPoint currentVelocity;
    
    //
    float health;
    int currentLap;
    BOOL isNewLap;
 
    //movement variables
    int normalizeState;
    float speed;
    float boost;
    
    //position and hovering variables
    float offset;
    float bobbing;

    
    //displayed speed and health
    float displayedSpeed;
    float displayedHeatlh;
}
@property CGPoint previousPosition, previousVelocity, currentVelocity;
@property (nonatomic, retain) CurvePosition *carTrackPosition;
@property float health, speed, boost, offset, bobbing, lifeTime, displayedSpeed, displayedHeatlh;
@property BOOL isCoolingDown, isNewLap;
@property int normalizeState, currentLap;

-(void)update:(ccTime) dt;



@end
