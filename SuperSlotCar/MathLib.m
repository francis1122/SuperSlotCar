//
//  MathLib.m
//  Demo Mac Port
//
//  Created by iPhone Dev Account on 7/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MathLib.h"


@implementation MathLib

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

+(float) distanceBetweenPoint:(CGPoint) pointA and:(CGPoint) pointB{
    return sqrtf( powf(pointA.x - pointB.x,2) + powf(pointA.y - pointB.y,2));
}



//vector math

+(float) calcAngleBetweenVectors:(CGPoint) v1 and:(CGPoint) v2{
    
    float dot = v1.x * v2.x + v1.y * v2.y;
    float angle = acosf(dot/( sqrt(powf(v1.x,2) + powf(v1.y,2)) * sqrt(powf(v2.x,2) + powf(v2.y,2)))  );
    return angle * 180/M_PI;
}

+(float) calcAngle:(CGPoint) p1 and:(CGPoint)p2{
    float angle = tan((p2.y-p1.y)/ (p2.x - p1.x)) * 180/M_PI;
    
    //if it is in the first quadrant
    if( p2.y < p1.y && p2.x > p1.x )
    {
        return angle;
    }
    //if its in the 2nd or 3rd quadrant
    if( ( p2.y < p1.y && p2.x < p1.x ) || ( p2.y > p1.y && p2.x < p1.x ) )
    {
        return angle + 180;
    }
    //it must be in the 4th quadrant so:
    return angle + 360;
}

@end
