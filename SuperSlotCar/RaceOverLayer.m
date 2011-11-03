//
//  RaceOverLayer.m
//  SuperSlotCar
//
//  Created by John Wilson on 9/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RaceOverLayer.h"
#import "LevelModel.h"
#import "MenuLayer.h"

@implementation RaceOverLayer

@synthesize raceTimeLabel;

-(id) init	
{
	
	if( (self=[super init])) {
        LevelModel *LM = [LevelModel sharedInstance];
        
        
        CCSprite *sprite1 = [CCSprite spriteWithFile:@"Icon-72.png"];
        CCSprite *sprite2 = [CCSprite spriteWithFile:@"Icon-72.png"];
        CCSprite *sprite3 = [CCSprite spriteWithFile:@"Icon-72.png"];
        CCMenuItemSprite *rematchButton = [CCMenuItemSprite itemFromNormalSprite:sprite1 selectedSprite:sprite2 disabledSprite:sprite3 target:self selector:@selector(rematchButtonTouched:)];
        rematchButton.position = ccp(120, 50);
        rematchButton.tag = 0;
        
        CCSprite *sprite10 = [CCSprite spriteWithFile:@"Icon-72.png"];
        CCSprite *sprite11 = [CCSprite spriteWithFile:@"Icon-72.png"];
        CCSprite *sprite12 = [CCSprite spriteWithFile:@"Icon-72.png"];
        CCMenuItemSprite *mainMenuButton = [CCMenuItemSprite itemFromNormalSprite:sprite10 selectedSprite:sprite11 disabledSprite:sprite12 target:self selector:@selector(mainMenuButtonTouched:)];
        mainMenuButton.position = ccp(220, 50);
        mainMenuButton.tag = 1;
        
        
        
        CCMenu *menu = [CCMenu menuWithItems: rematchButton, mainMenuButton,  nil];
        menu.position = CGPointZero;
        
        [self addChild:menu];
        


        self.raceTimeLabel = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"racetime:%f", time] fontName:SUPERSLOTCAR_FONT_1 fontSize:22];
        self.raceTimeLabel.position = CGPointMake(120, 200);
        [self addChild:raceTimeLabel];
        

        
    }
    return self;
}




#pragma -
#pragma button touches



-(void)rematchButtonTouched:(CCMenuItem*)sender{
    //restard the race
    LevelModel *LM = [LevelModel sharedInstance];
    LM.countDownToRaceStart = 3.0f;
    LM.isCountDownToRaceStarted = YES;
    
    //remove the raceBeginButton
   // [self removeChild:startMenu cleanup:YES];
    
}

-(void) mainMenuButtonTouched:(CCMenuItem*)sender{
    [[LevelModel sharedInstance] reset];
    [[CCDirector sharedDirector] replaceScene:[MenuLayer node]];
    
    
}

@end
