//
//  MyClass.h
//  Experimenting
//
//  Created by iPhone Dev Account on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BezierCurve : NSObject {
    CGPoint start, end;
    CGPoint control1, control2;
    //holds arcLength stuff 32 of them
    NSMutableArray *arcLengthArray;
    
    
    
    
    
}
@property (retain,nonatomic) NSMutableArray *arcLengthArray;
@property CGPoint start, end, control1, control2;


-(void) computeArcLengths;
-(CGPoint) findPositionOnCurve:(BezierCurve *)curve atTime:(float) t;
-(CGPoint) findSecondDerivativeOnCurve:(BezierCurve*) curve atTime:(float) t;
-(float) getArcLength:(float) u1;

-(float) findTimeGiven:(float) position;
@end
