//
//  TimeTrailLayer.m
//  SuperSlotCar
//
//  Created by John Wilson on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TimeTrailLayer.h"
#import "LevelScene.h"


@implementation TimeTrailLayer

-(id) init{
	if( (self=[super init] )) {
        CCLabelTTF* greatest = [CCLabelTTF labelWithString:@"Time Trail" fontName:@"AppleGothic" fontSize:20];
        greatest.position = ccp(280, 249);
        ccColor3B green = {154, 255, 56};
        [greatest setColor:green];
        [self addChild:greatest];
        
        
        [self setupTrackButtons];
        
    }
    return self;
}

-(void)setupTrackButtons{
    // CCLabelTTF *timeTrailLabel = [CCLabelTTF labelWithString:@"Time Trail" fontName:@"AppleGothic" fontSize:20];
    // CCMenuItemLabel *timeTrailerButton = [CCMenuItemLabel itemWithLabel:timeTrailLabel target:self selector:@selector(timeTrailTouched:)];

        CCSprite *sprite = [CCSprite spriteWithFile:@"Icon-72.png"];
        CCSprite *sprite2 = [CCSprite spriteWithFile:@"Icon-72.png"];
        CCSprite *sprite3 = [CCSprite spriteWithFile:@"Icon-72.png"];
        CCMenuItemSprite *spriteTimeTrailButton = [CCMenuItemSprite itemFromNormalSprite:sprite selectedSprite:sprite2 disabledSprite:sprite3 target:self selector:@selector(trackSelectorTouched:)];
        spriteTimeTrailButton.position = ccp(120, 140);
        spriteTimeTrailButton.tag = 0;
    
    
    CCSprite *sprite4 = [CCSprite spriteWithFile:@"Icon-72.png"];
    CCSprite *sprite5 = [CCSprite spriteWithFile:@"Icon-72.png"];
    CCSprite *sprite6 = [CCSprite spriteWithFile:@"Icon-72.png"];
    CCMenuItemSprite *spriteTimeTrailButton1 = [CCMenuItemSprite itemFromNormalSprite:sprite4 selectedSprite:sprite5 disabledSprite:sprite6 target:self selector:@selector(trackSelectorTouched:)];
    spriteTimeTrailButton1.position = ccp(220, 140);
    spriteTimeTrailButton1.tag = 1;
    
    CCSprite *sprite7 = [CCSprite spriteWithFile:@"Icon-72.png"];
    CCSprite *sprite8 = [CCSprite spriteWithFile:@"Icon-72.png"];
    CCSprite *sprite9 = [CCSprite spriteWithFile:@"Icon-72.png"];
    CCMenuItemSprite *spriteTimeTrailButton2 = [CCMenuItemSprite itemFromNormalSprite:sprite7 selectedSprite:sprite8 disabledSprite:sprite9 target:self selector:@selector(trackSelectorTouched:)];
    spriteTimeTrailButton2.position = ccp(120, 50);
    spriteTimeTrailButton2.tag = 2;
    
    CCSprite *sprite10 = [CCSprite spriteWithFile:@"Icon-72.png"];
    CCSprite *sprite11 = [CCSprite spriteWithFile:@"Icon-72.png"];
    CCSprite *sprite12 = [CCSprite spriteWithFile:@"Icon-72.png"];
    CCMenuItemSprite *spriteTimeTrailButton3 = [CCMenuItemSprite itemFromNormalSprite:sprite10 selectedSprite:sprite11 disabledSprite:sprite12 target:self selector:@selector(trackSelectorTouched:)];
    spriteTimeTrailButton3.position = ccp(220, 50);
    spriteTimeTrailButton3.tag = 3;


    
    CCMenu *menu = [CCMenu menuWithItems:spriteTimeTrailButton, spriteTimeTrailButton1, spriteTimeTrailButton2,spriteTimeTrailButton3, nil];
    menu.position = CGPointZero;
    [self addChild:menu];
    
}

-(void)trackSelectorTouched:(CCMenuItem*)sender{
    MasterDataModel *MDM = [MasterDataModel sharedInstance];
    switch (sender.tag) {
        case 0:
                MDM.currentTrackFile = @"track00";
            break;
        case 1:
                MDM.currentTrackFile = @"track01";
            break;
        case 2:
                MDM.currentTrackFile = @"track02";
        case 3:
                MDM.currentTrackFile = @"track03";
        default:
            break;
    }

    NSLog(@"touched");
    [[CCDirector sharedDirector] replaceScene:[LevelScene node]];
}

@end
