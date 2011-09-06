//
//  MyClass.m
//  Experimenting
//
//  Created by iPhone Dev Account on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BezierCurve.h"
#define BECK 128

@implementation BezierCurve
@synthesize start, end, control1, control2;
@synthesize arcLengthArray;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.arcLengthArray = [[NSMutableArray alloc] init];
        self.start = ccp(0,0);
        self.end = ccp(0,0);
        self.control1 = ccp(0,0);
        self.control2 = ccp(0,0);
        
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

-(void) computeArcLengths{
    
    float length = 0;
    int i;
    CGPoint previousPos = start;
    for( i = 0; i < 128; i++){
        float t = (float)i/127;
        CGPoint currentPosition = [self findPositionOnCurve:self atTime:t];
        float dist = length + sqrtf(pow(previousPos.x - currentPosition.x, 2) + pow(previousPos.y - currentPosition.y, 2));
        NSNumber *distance = [NSNumber numberWithFloat: dist];
        length = [distance floatValue];
        
        [arcLengthArray insertObject:distance atIndex:i];
        previousPos = currentPosition;
    }
}


-(CGPoint) findPositionOnCurve:(BezierCurve *)curve atTime:(float) t{
    //position

    float px = powf(1 - t, 3) * curve.start.x + 3.0f * powf(1 - t, 2) * t * curve.control1.x + 3.0f * (1 - t) * t * t * curve.control2.x + t * t * t * curve.end.x;
    float py = powf(1 - t, 3) * curve.start.y + 3.0f * powf(1 - t, 2) * t * curve.control1.y + 3.0f * (1 - t) * t * t * curve.control2.y + t * t * t * curve.end.y;
    return ccp(px, py);
}

-(float) getArcLength:(float) u1{

    if(u1 > 1){
        u1 = 1;
    }
    //get correct distance
    float spot = u1 * (127);
    int  lowSpot = (int)floor(spot);
    int highSpot = (int)ceil(spot);
    if(highSpot > 127){
        highSpot = 127;
    }
    if(lowSpot > 127){
        lowSpot = 127; 
    }
    if(highSpot < 0){
        highSpot = 0;
    }
    if(lowSpot < 0){
        lowSpot = 0;
    }
    NSNumber* lowDistance = [arcLengthArray objectAtIndex:lowSpot];
    NSNumber* highDistance = [arcLengthArray objectAtIndex:highSpot];
    
    float u0 = (float)lowSpot/(127);
    float u2 = (float)highSpot/(127);
    float bottom = u2 - u0;
    if(bottom == 0){
        return [highDistance floatValue];
    }
    float topOne = u2 - u1;
    float topTwo = u1 - u0;
    
    float left = (topOne/bottom)*[lowDistance floatValue];
    float right = (topTwo/bottom)*[highDistance floatValue];
    
    float distance = left + right;
    return distance;
    
    
}

-(float) findTimeGiven:(float) position{
    int index = 0;
    NSNumber *highSpot = NULL;
    while(index > 128 || highSpot == NULL){
        NSNumber *curveLength = [arcLengthArray objectAtIndex:index];
        if([curveLength floatValue] > position){
            highSpot = curveLength;
        }else{
            index++;        
        }
    }
    NSNumber *lowSpot = [arcLengthArray objectAtIndex:(index - 1)];
    
    float u0 = ((float)index-1)/127;
    float u1 = (float)index/127;
    float bottom = [highSpot floatValue] - [lowSpot floatValue];
    
    float topLeft = [highSpot floatValue] - position;
    float topRight = position - [lowSpot floatValue];
    
    float left = (topLeft / bottom) * u0;
    float right = (topRight / bottom) * u1;
    
    float time = left + right;
    
    return time;
    
    
    //use interpolation with low and high s to get time and return it
    
    
    
}

@end
