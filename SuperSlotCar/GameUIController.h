//
//  GameUIController.h
//  SuperSlotCar
//
//  Created by John Wilson on 10/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CarSprite;
@interface GameUIController : NSObject


+(void) update:(ccTime)dt;

+(void) refreshLapCountLabel:(CCLabelTTF*) label forCar:(CarSprite*) car;
@end
