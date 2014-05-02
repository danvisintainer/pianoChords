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
    int intKeys[MAXCHORDLENGTH];
    int diffKeys[MAXCHORDLENGTH];
}
@property NSMutableArray *keys;
@property int count;

-(void) processKey: (int) key;
-(void) addKey: (int) key;
-(void) deleteKey: (int) key;
-(BOOL) isKeyPressed: (int) key;
-(NSString*) calculate;

//-(NSString*) calcAndReturn;

-(void) outputArray;

@end
