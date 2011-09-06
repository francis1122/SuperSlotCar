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
    
    CGPoint previousPosition;
    CGPoint previousVelocity;
    CGPoint currentVelocity;
    //float
    float health;
    float speed;
    float boost;
}
@property CGPoint previousPosition, previousVelocity, currentVelocity;
@property (nonatomic, retain) CurvePosition *carTrackPosition;
@property float health, speed, boost;

-(void)update:(ccTime) dt;



@end
