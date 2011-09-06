//
//  BackgroundLayer.h
//  SuperSlotCar
//
//  Created by John Wilson on 9/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BackgroundLayer : CCLayer {
    
}

-(void) resolve;

-(void) createRect:(CGRect) rect WithTexture:(NSString*) texture;

@end
