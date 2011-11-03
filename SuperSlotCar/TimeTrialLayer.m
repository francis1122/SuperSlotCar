//
//  TimeTrialLayer.m
//  SuperSlotCar
//
//  Created by John Wilson on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TimeTrialLayer.h"
#import "LevelScene.h"


@implementation TimeTrialLayer

-(id) init{
	if( (self=[super init] )) {
        CCLabelTTF* greatest = [CCLabelTTF labelWithString:@"Time Trial" fontName:SUPERSLOTCAR_FONT_1 fontSize:20];
        greatest.position = ccp(280, 249);
        ccColor3B green = {154, 255, 56};
        [greatest setColor:green];
        [self addChild:greatest];
        
        
        [self setupTrackButtons];
        
    }
    return self;
}

-(void)setupTrackButtons{
    // CCLabelTTF *timeTrialLabel = [CCLabelTTF labelWithString:@"Time Trial" fontName:@"AppleGothic" fontSize:20];
    // CCMenuItemLabel *timeTrialerButton = [CCMenuItemLabel itemWithLabel:timeTrialLabel target:self selector:@selector(timeTrialTouched:)];

        CCSprite *sprite = [CCSprite spriteWithFile:@"Icon-72.png"];
        CCSprite *sprite2 = [CCSprite spriteWithFile:@"Icon-72.png"];
        CCSprite *sprite3 = [CCSprite spriteWithFile:@"Icon-72.png"];
        CCMenuItemSprite *spriteTimeTrialButton = [CCMenuItemSprite itemFromNormalSprite:sprite selectedSprite:sprite2 disabledSprite:sprite3 target:self selector:@selector(trackSelectorTouched:)];
        spriteTimeTrialButton.position = ccp(120, 140);
        spriteTimeTrialButton.tag = 0;
    
    
    CCSprite *sprite4 = [CCSprite spriteWithFile:@"Icon-72.png"];
    CCSprite *sprite5 = [CCSprite spriteWithFile:@"Icon-72.png"];
    CCSprite *sprite6 = [CCSprite spriteWithFile:@"Icon-72.png"];
    CCMenuItemSprite *spriteTimeTrialButton1 = [CCMenuItemSprite itemFromNormalSprite:sprite4 selectedSprite:sprite5 disabledSprite:sprite6 target:self selector:@selector(trackSelectorTouched:)];
    spriteTimeTrialButton1.position = ccp(220, 140);
    spriteTimeTrialButton1.tag = 1;
    
    CCSprite *sprite7 = [CCSprite spriteWithFile:@"Icon-72.png"];
    CCSprite *sprite8 = [CCSprite spriteWithFile:@"Icon-72.png"];
    CCSprite *sprite9 = [CCSprite spriteWithFile:@"Icon-72.png"];
    CCMenuItemSprite *spriteTimeTrialButton2 = [CCMenuItemSprite itemFromNormalSprite:sprite7 selectedSprite:sprite8 disabledSprite:sprite9 target:self selector:@selector(trackSelectorTouched:)];
    spriteTimeTrialButton2.position = ccp(120, 50);
    spriteTimeTrialButton2.tag = 2;
    
    CCSprite *sprite10 = [CCSprite spriteWithFile:@"Icon-72.png"];
    CCSprite *sprite11 = [CCSprite spriteWithFile:@"Icon-72.png"];
    CCSprite *sprite12 = [CCSprite spriteWithFile:@"Icon-72.png"];
    CCMenuItemSprite *spriteTimeTrialButton3 = [CCMenuItemSprite itemFromNormalSprite:sprite10 selectedSprite:sprite11 disabledSprite:sprite12 target:self selector:@selector(trackSelectorTouched:)];
    spriteTimeTrialButton3.position = ccp(220, 50);
    spriteTimeTrialButton3.tag = 3;


    
    CCMenu *menu = [CCMenu menuWithItems:spriteTimeTrialButton, spriteTimeTrialButton1, spriteTimeTrialButton2,spriteTimeTrialButton3, nil];
    menu.position = CGPointZero;
    [self addChild:menu];
    
}

-(void)trackSelectorTouched:(CCMenuItem*)sender{
    MasterDataModel *MDM = [MasterDataModel sharedInstance];
    switch (sender.tag) {
        case 0:
                MDM.currentTrackFile = @"track10";
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
