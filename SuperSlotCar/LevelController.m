//
//  LevelController.m
//  SuperSlotCar
//
//  Created by Hunter Francis on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelController.h"
#import "LevelScene.h"
#import "LevelLayer.h"
#import "TrackVO.h"
#import "CarSprite.h"
#import "RaceOverLayer.h"
#import "LevelModel.h"
#import "RaceOverLayer.h"


@implementation LevelController


+(void) update:(ccTime) dt{
    LevelModel *LM = [LevelModel sharedInstance];
    //if the race is in progress, update the car and interact withthe player stuff
    
    
    if(LM.raceInProgress){
        LM.raceTime += dt;

        [LevelController carMovement:LM.playerCar AlongTrack:LM.trackVO WithDelta:dt];
        [LevelController cameraMovementCenteredOn:LM.playerCar ForLayer:LM.levelLayer];
        [LevelController carHealthUpdate:LM.playerCar WithDelta:dt];
        [LevelController checkVictoryCondition:LM.playerCar];
    }else{
        if(LM.isCountDownToRaceStarted){
            [LevelController updateRaceCountdown:dt];
        }
    }
}

+ (void) updateRaceCountdown:(ccTime) dt{
    LevelModel *LM = [LevelModel sharedInstance];
    
    LM.countDownToRaceStart -= dt;
    if(LM.countDownToRaceStart < 0.0f){
        LM.raceInProgress = YES;
    }
}

+ (void) findParameterOnTrack:(TrackVO*)track WithCar:(CarSprite*) car WithSpeed:(float) s
{
    
    BezierCurve *spotCurve = [track.trackPoints objectAtIndex: car.carTrackPosition.index];
    //ensure that we remain within valid parameter space
    float lengthLeft = [BezierCurve arcLengthForCurve:spotCurve between:car.carTrackPosition.time and:1.0f];
    
    if(s > lengthLeft){
        if(car.carTrackPosition.index < [track.trackPoints count] - 1){
            car.carTrackPosition.index++;
        }else{
            car.carTrackPosition.index = 0;
            car.currentLap++;
            car.isNewLap;
        }
        car.carTrackPosition.time = 0;
        if([track.trackPoints count] >= car.carTrackPosition.index){
            spotCurve = [track.trackPoints objectAtIndex:car.carTrackPosition.index];
        }else{
            //error catcher?
            car.carTrackPosition.time = 0.0f;
            return;
        }
        
        car.carTrackPosition.time = 0.0f;
        float newSpeed = s - lengthLeft;
        [LevelController findParameterOnTrack:track WithCar:car WithSpeed: newSpeed];
        return;
    }
    
    
    //find position on curve we want to be at
    float newPositionOnCurve = [BezierCurve arcLengthForCurve:spotCurve between:0 and:car.carTrackPosition.time];
    
    car.carTrackPosition.time = [spotCurve findTimeGiven:newPositionOnCurve + s]; 
    
}



+(void) checkVictoryCondition:(CarSprite *) car{
    LevelModel *LM = [LevelModel sharedInstance];
    if(car.currentLap > 2 && !LM.isRaceOver){
        NSLog(@"victory");

        LM.isRaceOver = YES;
        [LM.gameLayer addChild:LM.raceOverLayer z:3 tag:3];
        [LM.raceOverLayer.raceTimeLabel setString:[NSString stringWithFormat:@"racetime:%f", LM.raceTime]];
    }

}

+(void) cameraMovementCenteredOn:(CarSprite*) car ForLayer:(CCLayer*) layer{
    float a = 1.0f;
    float b = 4.0f;
    float preZoom = layer.scaleX;
    float carSpeed = car.speed;
    if(carSpeed < 50){
        carSpeed = 50;
    }
    
    //    if(carSpeed 
    float zoom = 1/ ((logf(carSpeed/150 + a) - (logf(a) - logf(b)))/  logf(b));
    //    NSLog(@"zoom: %f",zoom);
    //    NSLog(@"zoom: %f", zoom);
    //  NSLog(@"carSpeed: %f", carSpeed);
    
    if(zoom > 1){
        zoom = 1;
    }
    
    float zoomDif = preZoom - zoom;
    float maxChange = 0.005;
    if(fabs(zoomDif) > maxChange){
        if(preZoom < zoom){
            zoom = preZoom + maxChange;
        }else{
            zoom = preZoom - maxChange;
        }
    }
    
    if(zoom < 0.3){
        zoom = 0.3;
    }
    
    layer.scaleX = zoom;
    layer.scaleY = zoom;
    
    CGPoint layerPosition = ccp( 240*layer.scaleX - car.position.x*layer.scaleX, 180*layer.scaleY - car.position.y*layer.scaleY);
    layer.position = layerPosition;
    
}

+(void) carMovement:(CarSprite*) car AlongTrack:(TrackVO*) track WithDelta:(ccTime)dt{
    LevelModel *LM = [LevelModel sharedInstance];
    //    [LevelController update:dt];
    
    //updates carPosition
    float realSpeed = (car.speed);
    
    //updates cars trackPosition, its abstract
    [LevelController findParameterOnTrack:LM.trackVO WithCar:car WithSpeed:realSpeed*dt];
    
    if(LM.isTouching && !car.isCoolingDown){
        LM.playerCar.speed += 35.0;
    }
    
    //deceleration of the car
    car.speed = car.speed * PLAYERCAR_DECELERATION;
    car.boost = 0.2;
    if(car.speed < 0.5){
        car.speed = 0.5;
    }
    car.lifeTime += dt;
    [LevelController carPositionUpdate:car AlongTrack:track];
}

+(void) carPositionUpdate:(CarSprite*) car AlongTrack:(TrackVO*) track{
    //update the cars position
    BezierCurve *carCurve = [track.trackPoints objectAtIndex:car.carTrackPosition.index];
    CGPoint position = [BezierCurve findPositionOnCurve:carCurve atTime:car.carTrackPosition.time];
    CGPoint deltaPosition = [BezierCurve findDerivativeOnCurve:carCurve atTime:car.carTrackPosition.time];
    
    
    //used to hover the car above the ground depending on speed
    GLfloat offset = 8 * (logf(car.speed)/logf(2.6));
    if(offset < 8){
        offset = 8;
    }
    float offsetDifference = car.offset - offset;
    if(fabs(offsetDifference) > 0.7){
        if(car.offset < offset){
            offset = car.offset + 0.7f;
        }else{
            offset = car.offset - 0.7f;
        }
    }
    float bobbing = 8*sinf(car.lifeTime*4);
    car.offset = offset;
    offset += bobbing;
    GLfloat offsetX = position.x - offset * (deltaPosition.y/sqrtf(deltaPosition.x * deltaPosition.x + deltaPosition.y * deltaPosition.y));
    GLfloat offsetY = position.y - offset * (-deltaPosition.x/ sqrtf(deltaPosition.x * deltaPosition.x + deltaPosition.y * deltaPosition.y));
    
    CGPoint offsetPosition = ccp(offsetX * CC_CONTENT_SCALE_FACTOR(), offsetY * CC_CONTENT_SCALE_FACTOR());
    
    car.previousPosition = car.position;
    car.position = offsetPosition;
    
    
    [LevelController carRotation:car ForTrack:track];
}

+(void) carHealthUpdate:(CarSprite*) car WithDelta:(ccTime)dt{
    car.previousVelocity = car.currentVelocity;
    //need to normalize the velocity;
    car.currentVelocity = ccp(car.position.x - car.previousPosition.x,
                              car.position.y - car.previousPosition.y);
    car.currentVelocity = [MathLib normalizeVector:car.currentVelocity];
    
    
    //checks make sure the numbers dont break the health system
    if(car.lifeTime > 1.0f && car.speed > 50.0f){
        car.normalizeState++;
        if(car.normalizeState > 8){
            float angleBetweenVelocity = [MathLib calcAngleBetweenVectors:car.currentVelocity and:car.previousVelocity];
            float change = angleBetweenVelocity/4;
            if(!isnan(angleBetweenVelocity)){
                float lim = 0.37f;
                if(change > lim){
                    car.health += PLAYERCAR_DAMAGE_SCALAR * (1+car.speed/600);
                }
            }
            //evaluate if the health is to high and the car should be inactive
            if(car.health > PLAYERCAR_MAX_HEALTH){
                car.isCoolingDown = YES;
            }
        }
    }else{
        car.normalizeState = 0;
    }
    if(car.health > 0.0f){
        car.health -= PLAYERCAR_HEALTH_REGEN;
    }
    if(car.health < 0.0f){
        car.health = 0.0f;
        car.isCoolingDown = NO;
    }
}

+(void) carRotation:(CarSprite*) car ForTrack:(TrackVO*) track{
    BezierCurve *spotCurve = [track.trackPoints objectAtIndex: car.carTrackPosition.index];
    CGPoint dC = [BezierCurve findDerivativeOnCurve:spotCurve atTime:car.carTrackPosition.time];
    float magnitude = sqrtf(dC.x * dC.x + dC.y * dC.y);
    float normalX = dC.y/magnitude;
    float normalY = -dC.x/magnitude;
    //    float angle = [MathLib calcAngle:ccp(0,0) and:ccp(normalX,normalY)];
    
    float playerRotation =     atan2f(normalY,normalX);
    car.rotation = ((-playerRotation)*180/M_PI) - 90;
    
}


#pragma -
#pragma touch
+(void) carBoostPreviousPos:(CGPoint) previousPosition AndCurrentPos:(CGPoint)currentPosition{
    //LevelModel *LM = [LevelModel sharedInstance];
//    if(!LM.playerCar.isCoolingDown){
      //  float dist = [MathLib distanceBetweenPoint:LM.previousTouch and:LM.currentTouch];
        //LM.playerCar.boost += dist * PLAYERCAR_ACCELERATION;
        //if(LM.playerCar.boost > PLAYERCAR_MAX_SPEED){
        //    LM.playerCar.boost = PLAYERCAR_MAX_SPEED;
       // }
  //  }
    
}



@end
