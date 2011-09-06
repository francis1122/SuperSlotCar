//
//  CurvePosition.h
//  SuperSlotCar
//
//  Created by Hunter Francis on 8/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CurvePosition : NSObject {
    
    int index;
    float time;
}

@property int index;
@property float time;

-(id) initWithIndex:(int) i andTime:(float)t;

@end
