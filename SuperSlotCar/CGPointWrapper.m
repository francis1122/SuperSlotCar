//
//  CGPointWrapper.m
//  Demo Mac Port
//
//  Created by iPhone Dev Account on 7/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CGPointWrapper.h"


@implementation CGPointWrapper

@synthesize point;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(id)initWithCGPoint:(CGPoint) point{
    self = [super init];
    if (self) {
        self.point = point;      
    }
    return self;    
}

- (void)dealloc
{
    [super dealloc];
}

@end
