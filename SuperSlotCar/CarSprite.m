//
//  CarSprite.m
//  SuperSlotCar
//
//  Created by Hunter Francis on 8/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CarSprite.h"



@implementation CarSprite

@synthesize carTrackPosition, health, speed, boost, previousPosition, previousVelocity, currentVelocity, offset, bobbing, lifeTime, displayedSpeed, isNewLap,
    displayedHeatlh, isCoolingDown, normalizeState, currentLap;

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
        self.currentLap = 0;
        self.boost = 0.7f;
        self.offset = 9.0f;
        self.lifeTime = 0.0f;
        self.bobbing = 0.0f;
        self.displayedHeatlh = 0.0f;
        self.displayedSpeed = 0.0f;
        self.isCoolingDown = NO;
        self.isNewLap = NO;
        self.normalizeState = 0;
        
	}
	return self;
}

-(void) dealloc{
    [super dealloc];
}


-(void)update:(ccTime) dt{
    
    
    
}

@end
