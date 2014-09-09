//
//  Chord.h
//  PianoChordsCocoa
//
//  Created by Dan Visintainer on 11/23/13.
//  Copyright (c) 2013 Dan Visintainer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface Chord : NSObject
{
    int intKeys[MAXCHORDLENGTH];    // this is the array of the actual keys the user pressed
    int diffKeys[MAXCHORDLENGTH];   // this is an array made as if 
}
@property NSMutableArray *keys;
@property int count;

-(void) modifyChordWithThisKey: (int) key;
-(BOOL) isKeyPressed: (int) key;
-(void) processTheseCoords: (float) x : (float) y;
-(int) chordContentsAt: (int) n;
-(void) sort;
-(void) reset;
-(void) parseTheString: (NSString*) input;

-(NSString*) calculate;

-(void) outputArray;

@end
