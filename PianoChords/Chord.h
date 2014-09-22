//
//  Chord.h
//  PianoChordsCocoa
//
//  Created by Dan Visintainer on 11/23/13.
//  Copyright (c) 2013 Dan Visintainer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface Chord : NSObject
{
    int intKeys[MAXCHORDLENGTH];    // this is the array of the actual keys the user pressed
    int diffKeys[MAXCHORDLENGTH];   // this is an array made as if the root compensation is applied
}

@property NSMutableArray *keys;
@property int count;

-(void) modifyChordWithThisKey: (int) key;
-(BOOL) isKeyPressed: (int) key;
-(int) chordContentsAt: (int) n;
-(void) reset;
-(NSString*) parseTheString: (NSString*) input;
-(NSString*) calculate;
-(void) outputArray;

@end
