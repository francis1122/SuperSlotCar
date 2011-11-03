//
//  LevelLayer.m
//  SuperSlotCar
//
//  Created by Hunter Francis on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LevelLayer.h"
#import "LevelController.h"
#import "TrackVO.h"
#import "CarSprite.h"
#import "LevelModel.h"
#import "PRFilledPolygon.h"
#import "MenuLayer.h"


@implementation LevelLayer

-(id) init	
{
	if( (self=[super init])) {
        MasterDataModel *MDM = [MasterDataModel sharedInstance];
        //load track
        LevelModel *LM = [LevelModel sharedInstance];
        if(MDM.currentTrackFile != NULL){
            LM.trackVO = [MDM getTrackVOByFilename:MDM.currentTrackFile];
        }else{
            NSLog(@"no Level loading in, we need to crash");
            [[CCDirector sharedDirector] replaceScene:[MenuLayer node]];
        }
        
        LM.playerCar = [[CarSprite alloc] initWithFile:@"Icon-72.png"];
        [self addChild:LM.playerCar z:1 tag: 2];
        self.isTouchEnabled = YES;
        
        [self createTrack:LM.trackVO WithTexture:@"repeat.png"];
    }
    return self;
}

-(void) resolve{
    //make sure things are setup for the first frame
    LevelModel *LM = [LevelModel sharedInstance];
    [LevelController carMovement:LM.playerCar AlongTrack:LM.trackVO WithDelta:0.001];
    [LevelController cameraMovementCenteredOn:LM.playerCar ForLayer:LM.levelLayer];
}

-(void) createTrack:(TrackVO*) track WithTexture:(NSString*) texture{
    
    NSMutableArray *polyArray = [[[NSMutableArray alloc] init] autorelease];
    // offsetPolyArray = [[NSMutableArray alloc] init];
    
    float offset = 4.0f;
    int segments = 16;
    for(BezierCurve *curve in track.trackPoints){
        float u = 0;
        for(NSUInteger i = 0; i < segments; i++)
        {
            CGPoint position = [BezierCurve findPositionOnCurve:curve atTime:u];
            CGPoint dP = [BezierCurve findDerivativeOnCurve:curve atTime:u];
            //offset the bastard
            GLfloat sX = position.x + offset * ( dP.y/ sqrtf(dP.x * dP.x + dP.y * dP.y) ); 
            GLfloat sY = position.y + offset * ( -dP.x/ sqrtf(dP.x * dP.x + dP.y * dP.y) ); 
            NSValue *point = [NSValue valueWithCGPoint: ccp(sX * CC_CONTENT_SCALE_FACTOR(), sY * CC_CONTENT_SCALE_FACTOR())];
            [polyArray addObject:point];
            u += 1.0f / segments;
        }
    }
    CCTexture2D *text = [[CCTextureCache sharedTextureCache] addImage:texture];
    PRFilledPolygon *filledPolygon = [[PRFilledPolygon alloc] initWithPoints:polyArray andTexture:text];
    
    [self addChild:filledPolygon z:0 tag:66];
    
    return;
}

-(void) dealloc{
    [super dealloc];	
}

/*
 -(void) update:(ccTime) dt{
 LevelModel *LM = [LevelModel sharedInstance];
 //    [LevelController update:dt];
 
 //updates carPosition
 
 float realSpeed = (LM.playerCar.speed+LM.playerCar.boost);
 //updates cars trackPosition, its abstract
 [LevelController findParameterOnTrack:LM.trackVO WithCar:LM.playerCar WithSpeed:realSpeed*dt];
 
 
 if(LM.isTouching){
 LM.playerCar.speed += 5.0;
 }
 
 LM.playerCar.speed = LM.playerCar.speed * 0.96;
 LM.playerCar.boost = LM.playerCar.boost * 0.9;
 
 // NSLog(@"realSpeed: %f", realSpeed);
 
 //camera movement
 BezierCurve *carCurve = [LM.trackVO.trackPoints objectAtIndex:LM.playerCar.carTrackPosition.index];
 CGPoint carSpot = [BezierCurve findPositionOnCurve:carCurve atTime:LM.playerCar.carTrackPosition.time];
 //updates cars position in game world
 LM.playerCar.previousPosition = LM.playerCar.position;
 LM.playerCar.position = carSpot;
 CGPoint layerPosition = ccp( 240*self.scaleX - carSpot.x*self.scaleX, 180*self.scaleY - carSpot.y*self.scaleY);
 self.position = layerPosition;
 self.scaleX = .5;
 self.scaleY = .5;
 
 
 
 
 //do health checking stuff
 LM.playerCar.previousVelocity = LM.playerCar.currentVelocity;
 LM.playerCar.currentVelocity = ccp(LM.playerCar.position.x - LM.playerCar.previousPosition.x,
 LM.playerCar.position.y - LM.playerCar.previousPosition.y);
 
 float angleBetweenVelocity = [MathLib calcAngleBetweenVectors:LM.playerCar.currentVelocity and:LM.playerCar.previousVelocity]/4;
 if(angleBetweenVelocity > 1){
 LM.playerCar.health += angleBetweenVelocity - 1; 
 }else{
 if(LM.playerCar.health > 0){
 LM.playerCar.health -= 0.04;
 }
 }
 }
 */

#pragma -
#pragma draw
-(void) draw{
    [super draw];
    //    BezierCurve *carCurve = [self.trackVO.trackPoints objectAtIndex:self.carPosition.index];
    
    //  CGPoint carSpot = [BezierCurve findPositionOnCurve:carCurve atTime:self.carPosition.time];
    LevelModel *LM = [LevelModel sharedInstance];
    //    ccDrawCircle(LM.playerCar.position, 10,0,16,NO);
    glLineWidth(1);
    /*    if( LM.trackVO != NULL){
     if( ![LM.trackVO isParsing] ){
     for(BezierCurve *curve in LM.trackVO.trackPoints){
     
     ccDrawCubicBezier(curve.start, curve.control1, curve.control2, curve.end, 32);   
     }
     }
     }
     */
    /*    CGPoint previous = [[outline objectAtIndex:0] CGPointValue];
     for(NSValue *point in outline){
     
     ccDrawLine(previous, [point CGPointValue]);
     previous = [point CGPointValue];
     
     }*/
    glLineWidth(4);
    ccDrawPoly([LM.trackVO getTrackOutline], LM.trackVO.outlineCount , NO);
}

#pragma -
#pragma touch



-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    LevelModel *LM = [LevelModel sharedInstance];
    if(LM.raceInProgress){
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView: [touch view]];
        // IMPORTANT:
        // The touches are always in "portrait" coordinates. You need to convert them to your current orientation
        CGPoint convertedPoint = [[CCDirector sharedDirector] convertToGL:location];
        
        LM.isTouching = YES;
        LM.touchBegan = convertedPoint;
        LM.previousTouch = convertedPoint;
    }
}


-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    LevelModel *LM = [LevelModel sharedInstance];
    if(LM.raceInProgress){
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView: [touch view]];
        // IMPORTANT:
        // The touches are always in "portrait" coordinates. You need to convert them to your current orientation
        CGPoint convertedPoint = [[CCDirector sharedDirector] convertToGL:location];
        
        LM.previousTouch = LM.currentTouch;
        LM.currentTouch = convertedPoint;
        
        [LevelController carBoostPreviousPos:LM.previousTouch AndCurrentPos:LM.currentTouch];
    }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    LevelModel *LM = [LevelModel sharedInstance];
    if(LM.raceInProgress){
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView: [touch view]];
        // IMPORTANT:
        // The touches are always in "portrait" coordinates. You need to convert them to your current orientation
        CGPoint convertedPoint = [[CCDirector sharedDirector] convertToGL:location];
        
        LM.isTouching = NO;
        LM.previousTouch = LM.currentTouch;
        LM.currentTouch = convertedPoint;
        LM.touchEnd = convertedPoint;
    }
}

@end
