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
@synthesize xmlString, currentCurve, isParsing;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.trackPoints = [[NSMutableArray alloc] init];
        self.isParsing = YES;
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
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
    self.isParsing = NO;
}


- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {

}




@end
