//
//  RaceOverLayer.h
//  SuperSlotCar
//
//  Created by John Wilson on 9/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface RaceOverLayer : CCLayer {
    
}

-(id) init;

#pragma -
#pragma button touches



-(void)rematchButtonTouched:(CCMenuItem*)sender;

-(void) mainMenuButtonTouched:(CCMenuItem*)sender;

@end
