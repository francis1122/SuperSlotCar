//
//  BackgroundLayer.m
//  SuperSlotCar
//
//  Created by John Wilson on 9/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BackgroundLayer.h"
#import "LevelModel.h"
#import "CarSprite.h"
#import "PRFilledPolygon.h"

@implementation BackgroundLayer

-(void) resolve{
    LevelModel *LM = [LevelModel sharedInstance];
    [self createRect:CGRectMake(-500, -500, 1000, 1000) WithTexture:@"clouds.png"];
    
    
    
}


-(void) createRect:(CGRect) rect WithTexture:(NSString*) texture{
    
    NSMutableArray *polyArray = [[[NSMutableArray alloc] init] autorelease];
    CGPoint bottomLeft = ccp( rect.origin.x, rect.origin.y);
    CGPoint topLeft = ccp( rect.origin.x, rect.origin.y + rect.size.height);
    CGPoint topRight = ccp( rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    CGPoint bottomRight = ccp( rect.origin.x + rect.size.width, rect.origin.y);
    
    NSValue *point = [NSValue valueWithCGPoint: ccp(bottomLeft.x * CC_CONTENT_SCALE_FACTOR(), bottomLeft.y * CC_CONTENT_SCALE_FACTOR()) ];
    [polyArray addObject:point];
    point = [NSValue valueWithCGPoint: ccp(topLeft.x * CC_CONTENT_SCALE_FACTOR(), topLeft.y * CC_CONTENT_SCALE_FACTOR()) ];
    [polyArray addObject:point];
    point = [NSValue valueWithCGPoint: ccp(topRight.x * CC_CONTENT_SCALE_FACTOR(), topRight.y * CC_CONTENT_SCALE_FACTOR()) ];
    [polyArray addObject:point];
    point = [NSValue valueWithCGPoint: ccp(bottomRight.x * CC_CONTENT_SCALE_FACTOR(), bottomRight.y * CC_CONTENT_SCALE_FACTOR()) ];
    [polyArray addObject:point];
    	
	
    CCTexture2D *text = [[CCTextureCache sharedTextureCache] addImage:texture];
    PRFilledPolygon *filledPolygon = [[PRFilledPolygon alloc] initWithPoints:polyArray andTexture:text];
    
    
    [self addChild:filledPolygon z:0 tag:99];
    
    
    
    
    return;
    
}


#pragma -
#pragma draw
-(void) draw{
    [super draw];
    //    BezierCurve *carCurve = [self.trackVO.trackPoints objectAtIndex:self.carPosition.index];
    
    //  CGPoint carSpot = [BezierCurve findPositionOnCurve:carCurve atTime:self.carPosition.time];
    LevelModel *LM = [LevelModel sharedInstance];
    
    //draw health bar
  //  float line = LM.playerCar.health* 10;
    //        float line = 500/5;
//    ccDrawLine(ccp(20,  200), ccp( 20 + line, 200));
    
}


@end
