//
//  MenuLayer.m
//  SuperSlotCar
//
//  Created by John Wilson on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MenuLayer.h"
#import "TimeTrailLayer.h"


@implementation MenuLayer

-(id) init{
	if( (self=[super init] )) {
        CCLabelTTF* greatest = [CCLabelTTF labelWithString:@"Super Slot Car" fontName:@"AppleGothic" fontSize:20];
        greatest.position = ccp(280, 249);
        ccColor3B green = {154, 255, 56};
        [greatest setColor:green];
        [self addChild:greatest];

        
       // CCLabelTTF *timeTrailLabel = [CCLabelTTF labelWithString:@"Time Trail" fontName:@"AppleGothic" fontSize:20];
       // CCMenuItemLabel *timeTrailerButton = [CCMenuItemLabel itemWithLabel:timeTrailLabel target:self selector:@selector(timeTrailTouched:)];
        CCSprite *sprite = [CCSprite spriteWithFile:@"Icon-72.png"];
        CCSprite *sprite2 = [CCSprite spriteWithFile:@"Icon-72.png"];
        CCSprite *sprite3 = [CCSprite spriteWithFile:@"Icon-72.png"];
        
        CCMenuItemSprite *spriteTimeTrailButton = [CCMenuItemSprite itemFromNormalSprite:sprite selectedSprite:sprite2 disabledSprite:sprite3 target:self selector:@selector(timeTrailTouched:)];
        spriteTimeTrailButton.position = ccp(220, 140);
        
        CCMenu *menu = [CCMenu menuWithItems:spriteTimeTrailButton, nil];
        menu.position = CGPointZero;
        [self addChild:menu];
        
    }
    return self;
}

-(void)timeTrailTouched:(CCMenuItem*)sender{
    
    NSLog(@"touched");
    [[CCDirector sharedDirector] replaceScene:[TimeTrailLayer node]];
}
    
@end
