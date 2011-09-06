//
//  CarSprite.m
//  SuperSlotCar
//
//  Created by Hunter Francis on 8/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CarSprite.h"



@implementation CarSprite

@synthesize carTrackPosition, health, speed, boost, previousPosition, previousVelocity, currentVelocity;

-(id) initWithTexture:(CCTexture2D*)texture rect:(CGRect)rect
{
	NSAssert(texture!=nil, @"Invalid texture for sprite");
	// IMPORTANT: [self init] and not [super init];
	if( (self = [self init]) )
	{
		[self setTexture:texture];
		[self setTextureRect:rect];
        self.previousPosition = ccp(0,0);
        self.previousVelocity = ccp(0,0);
        self.currentVelocity = ccp(0,0);
        self.carTrackPosition = [[[CurvePosition alloc] initWithIndex:0 andTime:1.0f] autorelease];
        self.health = 0.0f;
        self.speed = 0.7f;
        self.boost = 0.0f;
        
	}
	return self;
}

-(void) dealloc{
    [super dealloc];
}

-(void)update:(ccTime) dt{
    
    
    
}

@end
