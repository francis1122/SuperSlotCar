//
//  CGPointWrapper.h
//  Demo Mac Port
//
//  Created by iPhone Dev Account on 7/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CGPointWrapper : NSObject {

    CGPoint point;
    
}

@property CGPoint point;

-(id)initWithCGPoint:(CGPoint) point;


@end
