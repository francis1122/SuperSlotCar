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
#import "LevelModel.h"


@implementation LevelController


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
        float newSpeed = s- lengthLeft;
        [LevelController findParameterOnTrack:track WithCar:car WithSpeed: newSpeed];
        return;
    }
    
    
    //find position on curve we want to be at
    float newPositionOnCurve = [BezierCurve arcLengthForCurve:spotCurve between:0 and:car.carTrackPosition.time];
    
    car.carTrackPosition.time = [spotCurve findTimeGiven:newPositionOnCurve + s]; 
    
}



+(void) update:(ccTime) dt{
        LevelModel *LM = [LevelModel sharedInstance];
    
    [LevelController carMovement:LM.playerCar AlongTrack:LM.trackVO WithDelta:dt];
    [LevelController cameraMovementCenteredOn:LM.playerCar ForLayer:LM.levelLayer];
    [LevelController carHealthUpdate:LM.playerCar WithDelta:dt];
    
}

+(void) cameraMovementCenteredOn:(CarSprite*) car ForLayer:(CCLayer*) layer{
    float a = 1.0f;
    float b = 5.0f;
    float preZoom = layer.scaleX;
    float carSpeed = car.boost;
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
    float maxChange = 0.004;
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
    float realSpeed = (car.speed+LM.playerCar.boost);
    
    //updates cars trackPosition, its abstract
    [LevelController findParameterOnTrack:LM.trackVO WithCar:car WithSpeed:realSpeed*dt];
    
    if(LM.isTouching){
        LM.playerCar.speed += 1.0;
    }

    //deceleration of the car
    car.speed = car.speed * 0.98;
    car.boost = car.boost * 0.9745;
    car.lifeTime += dt;
    

    

    [LevelController carPositionUpdate:car AlongTrack:track];

    
}

+(void) carPositionUpdate:(CarSprite*) car AlongTrack:(TrackVO*) track{
    //update the cars position
    BezierCurve *carCurve = [track.trackPoints objectAtIndex:car.carTrackPosition.index];
    CGPoint position = [BezierCurve findPositionOnCurve:carCurve atTime:car.carTrackPosition.time];
    CGPoint deltaPosition = [BezierCurve findDerivativeOnCurve:carCurve atTime:car.carTrackPosition.time];
    
    GLfloat offset = 8 * (logf(car.boost)/logf(2.6));
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
    float bobbing = 3*sinf(car.lifeTime*2);
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
    car.currentVelocity = ccp(car.position.x - car.previousPosition.x,
                                       car.position.y - car.previousPosition.y);
    
    float angleBetweenVelocity = [MathLib calcAngleBetweenVectors:car.currentVelocity and:car.previousVelocity]/4;
    if(angleBetweenVelocity > 1){
        car.health += angleBetweenVelocity - 1; 
    }else{
        if(car.health > 0){
            car.health -= 0.04;
        }
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
    LevelModel *LM = [LevelModel sharedInstance];
    float dist = [MathLib distanceBetweenPoint:LM.previousTouch and:LM.currentTouch];
    LM.playerCar.boost += dist * 1;
    
}
    
    
    
    @end
