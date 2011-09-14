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
    
    
    NSString* currentTrackFile;
}
@property (nonatomic, retain) NSString *currentTrackFile;
+ (id)sharedInstance;

-(TrackVO*) getTrackVOByFilename:(NSString*) trackFilename;

@end
