//
//  LevelLayer.h
//  SuperSlotCar
//
//  Created by Hunter Francis on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LevelLayer : CCLayer {

    
    
}

-(id) init;

-(void) resolve;

-(void)dealloc;

-(void) createTrack:(TrackVO*) track WithTexture:(NSString*) texture;

-(void) update:(ccTime) dt;

-(void) draw;

@end
