//
//  MasterDataModel.h
//  SuperSlotCar
//
//  Created by Hunter Francis on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TrackVO;
@interface MasterDataModel : NSObject {
    
}

+ (id)sharedInstance;

-(TrackVO*) getTrackVOByFilename:(NSString*) trackFilename;

@end
