//
//  MasterDataModel.m
//  SuperSlotCar
//
//  Created by Hunter Francis on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MasterDataModel.h"
#import "TrackVO.h"

static MasterDataModel *sharedInstance = nil;

@implementation MasterDataModel

+ (id)sharedInstance{ 
    @synchronized(self){
        if(sharedInstance == nil)
            sharedInstance = [[[self class] alloc] init];
    }
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

-(TrackVO*) getTrackVOByFilename:(NSString*) trackFilename{
    
    TrackVO *track = [[TrackVO alloc] init];
    [track parseTrack:trackFilename];
    return track;
}

@end
