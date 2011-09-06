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

@end
