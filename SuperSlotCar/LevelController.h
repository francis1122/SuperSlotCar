//
//  LevelController.h
//  SuperSlotCar
//
//  Created by Hunter Francis on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CarSprite;
@interface LevelController : NSObject {
    
}
+(void) update:(ccTime) dt;

+ (void) updateRaceCountdown:(ccTime) dt;

//u1 is current spot on curve, and s is the speed of movement
+ (void) findParameterOnTrack:(TrackVO*)track WithCar:(CarSprite*) car WithSpeed:(float) s;

+(void) checkVictoryCondition:(CarSprite *) car;

+(void) cameraMovementCenteredOn:(CarSprite*) car ForLayer:(CCLayer*) layer;

+(void) carMovement:(CarSprite*) car AlongTrack:(TrackVO*) track WithDelta:(ccTime)dt;

+(void) carPositionUpdate:(CarSprite*) car AlongTrack:(TrackVO*) track;

+(void) carHealthUpdate:(CarSprite*) car WithDelta:(ccTime)dt;

+(void) carRotation:(CarSprite*) car ForTrack:(TrackVO*) track;
#pragma -
#pragma touch
+(void) carBoostPreviousPos:(CGPoint) previousPosition AndCurrentPos:(CGPoint)currentPosition;

@end
