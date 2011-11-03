//
//  GameUILayer.h
//  SuperSlotCar
//
//  Created by John Wilson on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameUILayer : CCLayer {
    
    CCMenu *startMenu;
    CCLabelTTF *lapCountLabel;
    
}

@property (nonatomic, retain) CCLabelTTF *lapCountLabel;


-(void) setupLapCounter;

@end
