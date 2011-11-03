//
//  TrackVO.m
//  Demo Mac Port
//
//  Created by iPhone Dev Account on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TrackVO.h"


@implementation TrackVO

@synthesize trackPoints;
@synthesize xmlString, currentCurve, isParsing, outlineCount;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.trackPoints = [[[NSMutableArray alloc] init] autorelease];
//        self.trackOutline = [[[NSMutableArray alloc] init] autorelease]; 
        self.isParsing = YES;
    }
    
    return self;
}

- (void)dealloc
{
    free(trackOutline);
    [super dealloc];
}


-(void)createTrackOutlineWithPoints:(NSMutableArray*) _trackPoints{
    NSMutableArray *polyArrayInner = [[[NSMutableArray alloc] init] autorelease];
    NSMutableArray *polyArrayOuter = [[[NSMutableArray alloc] init] autorelease];
    NSMutableArray *outlineA = [[[NSMutableArray alloc] init] autorelease];
    

    //inner points
    int segments = 16;
    float offset = 4.0f;
    for(BezierCurve *curve in _trackPoints){
        float u = 0;
        for(NSUInteger i = 0; i < segments; i++)
        {
            CGPoint position = [BezierCurve findPositionOnCurve:curve atTime:u];
            CGPoint dP = [BezierCurve findDerivativeOnCurve:curve atTime:u];
            //offset the bastard
            GLfloat sX = position.x + offset * ( dP.y/ sqrtf(dP.x * dP.x + dP.y * dP.y) ); 
            GLfloat sY = position.y + offset * ( -dP.x/ sqrtf(dP.x * dP.x + dP.y * dP.y) ); 
            NSValue *point = [NSValue valueWithCGPoint: ccp(sX * CC_CONTENT_SCALE_FACTOR(), sY * CC_CONTENT_SCALE_FACTOR())];
            [polyArrayInner addObject:point];
            u += 1.0f / segments;
        }
    }
    
    //outer points
    //    int segments = 16;
    
    offset = 0.0f;
    for(BezierCurve *curve in _trackPoints){
        float u = 0;
        for(NSUInteger i = 0; i < segments; i++)
        {
            
            CGPoint position = [BezierCurve findPositionOnCurve:curve atTime:u];
            CGPoint dP = [BezierCurve findDerivativeOnCurve:curve atTime:u];
            //offset the bastard
            GLfloat sX = position.x + offset * ( dP.y/ sqrtf(dP.x * dP.x + dP.y * dP.y) ); 
            GLfloat sY = position.y + offset * ( -dP.x/ sqrtf(dP.x * dP.x + dP.y * dP.y) ); 
            NSValue *point = [NSValue valueWithCGPoint: ccp(sX * CC_CONTENT_SCALE_FACTOR(), sY * CC_CONTENT_SCALE_FACTOR())];
            [polyArrayOuter addObject:point];
            u += 1.0f / segments;
            
            
        }
    }
    
    for(int i = 0; i < polyArrayInner.count - 1; i++){
        
        
        CGPoint interA = [[polyArrayInner objectAtIndex:i] CGPointValue];
        CGPoint outerA = [[polyArrayOuter objectAtIndex:i] CGPointValue];
        CGPoint interB = [[polyArrayInner objectAtIndex:i+1] CGPointValue];
        CGPoint outerB = [[polyArrayOuter objectAtIndex:i+1] CGPointValue];
        
        
        [outlineA addObject:[NSValue valueWithCGPoint: ccp(interA.x * CC_CONTENT_SCALE_FACTOR(), interA.y * CC_CONTENT_SCALE_FACTOR())]];
        [outlineA addObject:[NSValue valueWithCGPoint: ccp(outerA.x * CC_CONTENT_SCALE_FACTOR(), outerA.y * CC_CONTENT_SCALE_FACTOR())]];
        [outlineA addObject:[NSValue valueWithCGPoint: ccp(outerB.x * CC_CONTENT_SCALE_FACTOR(), outerB.y * CC_CONTENT_SCALE_FACTOR())]];
        
        
        [outlineA addObject:[NSValue valueWithCGPoint: ccp(outerB.x * CC_CONTENT_SCALE_FACTOR(), outerB.y * CC_CONTENT_SCALE_FACTOR())]];
        [outlineA addObject:[NSValue valueWithCGPoint: ccp(interB.x * CC_CONTENT_SCALE_FACTOR(), interB.y * CC_CONTENT_SCALE_FACTOR())]];
        [outlineA addObject:[NSValue valueWithCGPoint: ccp(interA.x * CC_CONTENT_SCALE_FACTOR(), interA.y * CC_CONTENT_SCALE_FACTOR())]];
  
        
        
    }
    
    outlineCount = outlineA.count;
    trackOutline = (CGPoint*)malloc(sizeof(CGPoint)*outlineCount);
    
    [NSValue valueWithCGPoint:CGPointMake(5.5, 6.6)] ;
    //fill up opengl array
    for(int i = 0; i < outlineCount; i++){
        CGPoint value = [[outlineA objectAtIndex:i] CGPointValue];
//        [NSValue valueWithCGPoint:value];
        trackOutline[i] = value;
  //      [outlineArray addObject:[outlineA objectAtIndex:i]];
        
        
    }
    
    
}

-(CGPoint *)getTrackOutline{
    
    return trackOutline;
}

# pragma mark ---------- PARSER ----------
// parse the level assets for use in gameplay
-(void) parseTrack:(NSString*) trackFilename{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:trackFilename ofType:@"xml"];
    
	NSData *trackData = [[NSData alloc] initWithContentsOfFile:filePath];
	NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:trackData];
	[xmlParser setDelegate:self];
    self.isParsing = YES;
	[xmlParser parse];	
	[trackData release];
	[xmlParser autorelease];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
    self.xmlString = @"";
    if([elementName isEqualToString:@"Curve"]){
        self.currentCurve = [[[BezierCurve alloc] init] autorelease];
        [self.trackPoints addObject:currentCurve];
    }
}



- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
    if( [elementName isEqualToString:@"startX"]){
        self.currentCurve.start = ccp([xmlString floatValue], self.currentCurve.start.y);
    }
    if( [elementName isEqualToString:@"startY"]){
        self.currentCurve.start = ccp(self.currentCurve.start.x, [xmlString floatValue]);
    }
    
    if( [elementName isEqualToString:@"endX"]){
        self.currentCurve.end = ccp([xmlString floatValue], self.currentCurve.end.y);
    }
    if( [elementName isEqualToString:@"endY"]){
        self.currentCurve.end = ccp(self.currentCurve.end.x, [xmlString floatValue]);
    }
    
    if( [elementName isEqualToString:@"control1X"]){
        self.currentCurve.control1 = ccp([xmlString floatValue], self.currentCurve.control1.y);
    }
    if( [elementName isEqualToString:@"control1Y"]){
        self.currentCurve.control1 = ccp(self.currentCurve.control1.x, [xmlString floatValue]);
    }
    
    if( [elementName isEqualToString:@"control2X"]){
        self.currentCurve.control2 = ccp([xmlString floatValue], self.currentCurve.control2.y);
    }
    if( [elementName isEqualToString:@"control2Y"]){
        self.currentCurve.control2 = ccp(self.currentCurve.control2.x, [xmlString floatValue]);
    }
	
    
} 




- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    self.xmlString = string;
	
	
}

- (void)parser:(NSXMLParser *)parser foundIgnorableWhitespace:(NSString *)whitespaceString {
	
}


- (void)parserDidEndDocument:(NSXMLParser *)parser {
    //calculate arc Lengths here
    for(BezierCurve *curve in self.trackPoints){
        [curve computeArcLengths];
    }
    //calculate the outline
    [self createTrackOutlineWithPoints:self.trackPoints];
    self.isParsing = NO;
}


- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {

}




@end
