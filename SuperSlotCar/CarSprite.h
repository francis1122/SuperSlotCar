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

    //how long entity has been alive for
    float lifeTime;
    
    CGPoint previousPosition;
    CGPoint previousVelocity;
    CGPoint currentVelocity;
    //float
    float health;
    float speed;
    float boost;
    
    //position and hovering variables
    float offset;
    float bobbing;

}
@property CGPoint previousPosition, previousVelocity, currentVelocity;
@property (nonatomic, retain) CurvePosition *carTrackPosition;
@property float health, speed, boost, offset, bobbing, lifeTime;

-(void)update:(ccTime) dt;



@end
