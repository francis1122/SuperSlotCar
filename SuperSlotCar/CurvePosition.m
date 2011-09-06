//
//  CurvePosition.m
//  SuperSlotCar
//
//  Created by Hunter Francis on 8/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CurvePosition.h"


@implementation CurvePosition

@synthesize time;
@synthesize index;

-(id) initWithIndex:(int) i andTime:(float)t{
    self.time = t;
    self.index = i;
    return self;
}

@end
