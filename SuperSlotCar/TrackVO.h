//
//  TrackVO.h
//  Demo Mac Port
//
//  Created by iPhone Dev Account on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TrackVO : NSObject <NSXMLParserDelegate> {

    NSMutableArray *trackPoints;
    BezierCurve *currentCurve;

    
    NSMutableString *xmlString;
    
    CGPoint *trackOutline;
    int outlineCount;
    
    BOOL isParsing;
}

@property (nonatomic, retain) NSMutableArray *trackPoints;
@property (nonatomic, retain) NSMutableString *xmlString;
@property (nonatomic, retain) BezierCurve *currentCurve;
@property int outlineCount;
@property BOOL isParsing;

-(void) parseTrack:(NSString*) trackFilename;
-(void)createTrackOutlineWithPoints:(NSMutableArray*) _trackPoints;
-(CGPoint *)getTrackOutline;

@end
