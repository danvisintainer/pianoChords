//
//  Chord.m
//  PianoChordsCocoa
//
//  Created by Dan Visintainer on 11/23/13.
//  Copyright (c) 2013 Dan Visintainer. All rights reserved.
//

#import "Chord.h"
#import "Constants.h"
#import "keyAudioPlayer.h"
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>

@implementation Chord
{
    keyAudioPlayer *KeyAudioPlayer;
}

@synthesize keys;
@synthesize count;

-(id) init
{
    self = [super init];
    
    if (self)
    {
        //keys = [[NSMutableArray alloc] init];
        count = 0;
        
        for (int i = 0; i < MAXCHORDLENGTH; i++)
            intKeys[i] = 99;
        
        for (int i = 0; i < MAXCHORDLENGTH; i++)
            diffKeys[i] = 99;
        
        KeyAudioPlayer = [[keyAudioPlayer alloc] init];
        
    }
    
    return self;
}

-(void) modifyChordWithThisKey: (int) key;
{
    if (![self isKeyPressed:key])   // if key has not already been pressed
    {
        NSLog(@"Adding key %i", key);
        
        [KeyAudioPlayer playTheKey:key];
        
        if (count >= MAXCHORDLENGTH)
            NSLog(@"Too many keys, doing nothing.");
        else if (key == -1)
            NSLog(@"Oops, looks like an invalid key was pressed! Doing nothing.");
        else
        {
            intKeys[count] = key;
            count++;
            
            [self customSort:intKeys withSize:count];
            
        }
    }
    else
    {
        int i = 0;
        bool done = false;
        NSLog(@"Removing key %i", key);
        
        while (!done)
        {
            if (intKeys[i] == key)
                done = true;
            else
                i++;
        }
        
        intKeys[i] = 99;
        
        [self customSort:intKeys withSize:count];
        count--;
        // [self outputdiffKeys];
    }
}

-(BOOL) isKeyPressed: (int) key
{
    bool found = false;
    
    for (int i = 0; i < MAXCHORDLENGTH; i++)
    {
        if (intKeys[i] == key)
            found = true;
    }
    
    if (found)
        return true;
    else
        return false;
}

-(void) customSort:(int*)a withSize:(int) n  // an implementation of QuickSort, modified a bit to work with this kind of app
{
    if (n < 2)
        return;
    int p = a[n / 2];
    int *l = a;
    int *r = a + n - 1;
    while (l <= r) {
        if (*l < p) {
            l++;
            continue;
        }
        if (*r > p) {
            r--;
            continue;
        }
        int t = *l;
        *l++ = *r;
        *r-- = t;
    }
    [self customSort:a withSize:r - a + 1];
    [self customSort:l withSize:a + n - l];//quick_sort(l, a + n - l);
}

-(NSString*) calculate
{
    // [keys sortUsingSelector: @selector(compare:)];
    
    int rootDifference = intKeys[0] - 1;
    int root = intKeys[0];
    NSString* mod = @"";
    
    if (count == 1)
    {
        //mod = [self intToPitch:intKeys[0]];
    }
    
    else if (count == 2)
    {
        for (int i = 0; i < MAXCHORDLENGTH; i++)
        diffKeys[i] = intKeys[i] - rootDifference;
        
        switch (diffKeys[1]) {   // case for a two-pitch cord. what is the SECOND key
            case 2:     mod = @"M7";        root = intKeys[1];  break;
            case 3:     mod = @"7";         root = intKeys[1];  break;
            case 4:     mod = @"m";         break;
            case 6:     root = intKeys[1];  break;
            case 7:     mod = @"dim7";      break;
            case 9:     root = intKeys[1];  break;
            case 10:    mod = @"m";         root = intKeys[1];  break;
            case 11:    mod = @"7";         break;
            case 12:    mod = @"M7";        break;
            default:    break;
        }
    }
    
    else if (count > 2)
    {
        for (int i = 0; i < MAXCHORDLENGTH; i++)
            diffKeys[i] = intKeys[i] - rootDifference;
        
        if (diffKeys[1] == 5 && diffKeys[2] == 8 && count > 3)   // if it's a major chord
        {
            switch (diffKeys[3])
            {
                case 10:    mod = @"6";    break;
                case 11:    mod = @"7";    break;
                case 12:    mod = @"M7";   break;
            }
        }
        
        else if (diffKeys[1] == 4 && diffKeys[2] == 8)  // if it's minor
        {
            if (count == 4)
            {
                switch (diffKeys[3])
                {
                    case 9:     mod = @"M7";    root = intKeys[3];  break;
                    case 10:	mod = @"m6"; 	break;
                    case 11:	mod = @"m7"; 	break;
                    case 12:	mod = @"mM7"; 	break;
                    case 15:	mod = @"add9";	break;
                }
            }
            
            else
                mod = @"m";
        }
        
        if (diffKeys[1] == 4 && diffKeys[2] == 7) // if it's diminished
        {
            if (count == 4 && diffKeys[3] == 11)
                mod = @"m7b5";
            if (count == 4 && diffKeys[3] == 10)
                mod = @"dim7";
            else
                mod = @"dim";
        }
        
        if (diffKeys[1] == 6 && diffKeys[2] == 8) //
        {
            if (count == 4 && diffKeys[3] == 10)
            {
                mod = @"add9";
                root = intKeys[2];
            }
            if (count == 4 && diffKeys[3] == 11)
                mod = @"7sus4";
            if (count == 4 && diffKeys[3] == 15)
            {
                mod = @"add9";
                root = intKeys[2];
            }
            else
                mod = @"sus4";
        }
        
        if (diffKeys[1] == 8 && diffKeys[2] == 10)
            mod = @"6";
        
        if (diffKeys[1] == 5 && diffKeys[2] == 10)
        {
            root = intKeys[2];
            mod = @"m";
        }
        
        if (diffKeys[1] == 6 && diffKeys[2] == 10)
            root = intKeys[1];
        
        if (diffKeys[1] == 6 && diffKeys[2] == 9)
        {
            root = intKeys[1];
            mod = @"m";
        }
        
        if (diffKeys[1] == 4 && diffKeys[2] == 9)
            root = intKeys[2];
        
        if (diffKeys[1] == 5 && diffKeys[2] == 8)
            mod = @"aug";
        
        if (diffKeys[1] == 3 && diffKeys[2] == 6)
        {
            mod = @"m7";
            root = intKeys[1];
        }
        
        if (diffKeys[1] == 9 && diffKeys[2] == 11)
        {
            mod = @"add9";
            root = intKeys[1];
        }
        
        if (count > 3)  // account for some of the more "arbitrary" chords
        {
            if (diffKeys[1] == 3 && diffKeys[2] == 5 && diffKeys[3] == 8)
                mod = @"add9";
            
            if (diffKeys[1] == 3 && diffKeys[2] == 4 && diffKeys[3] == 8)
                mod = @"madd9";
            
            if (diffKeys[1] == 5 && diffKeys[2] == 7 && diffKeys[3] == 10)
            {
                mod = @"m7b5";
                root = intKeys[2];
            }
            
            if (diffKeys[1] == 5 && diffKeys[2] == 7 && diffKeys[3] == 11)
                mod = @"7b5";
        }
        
    }
    
    // return text;
    return [NSString stringWithFormat:@"%@%@", [self intToPitch:root], mod];
}

-(NSString*) parseTheString: (NSString*) input;
{
    NSInteger stringIndex = 0;
    
    int keysToAdd[4] = {1, 5, 8, 13};
    int compensation = 0;
    int errors = 0;
    NSMutableString *resultingChord = [NSMutableString stringWithString:@""];
    
    input = [input stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // the chord must begin with "A"-"G" or "a"-"g". these if-statements check on that.
    if ((((int)[input characterAtIndex:0]) >= 65
        && ((int)[input characterAtIndex:0]) <= 71) ||
        (((int)[input characterAtIndex:0]) >= 97
         && ((int)[input characterAtIndex:0]) <= 103))
    {
        switch ([input characterAtIndex:0]){
            case 'C':	compensation = 0;	[resultingChord appendString:@"C"]; 	break;
            case 'D':	compensation = 2;	[resultingChord appendString:@"D"];	break;
            case 'E':	compensation = 4;	[resultingChord appendString:@"E"];	break;
            case 'F':	compensation = 5;	[resultingChord appendString:@"F"];	break;
            case 'G':	compensation = 7;	[resultingChord appendString:@"G"];	break;
            case 'A':	compensation = 9;	[resultingChord appendString:@"A"];	break;
            case 'B':	compensation = 11;	[resultingChord appendString:@"B"];	break;
            case 'c':	compensation = 0;	[resultingChord appendString:@"C"];	break;
            case 'd':	compensation = 2;	[resultingChord appendString:@"D"];	break;
            case 'e':	compensation = 4;	[resultingChord appendString:@"E"];	break;
            case 'f':	compensation = 5;	[resultingChord appendString:@"F"];	break;
            case 'g':	compensation = 7;	[resultingChord appendString:@"G"];	break;
            case 'a':	compensation = 9;	[resultingChord appendString:@"A"];	break;
            case 'b':	compensation = 11;	[resultingChord appendString:@"B"];	break;
		}
    }
    else
        errors = 1;
    
    // if the chord has no mods (1 char string), then there's nothing else to do.
    // otherwise, we'll parse the rest of it.
    if (input.length > 1)
    {
        // next, we'll check if the chord base is sharp or flat
        if ([input characterAtIndex:1] == '#' && errors == 0)
        {
            [resultingChord appendString:@"#"];
            compensation++;
            stringIndex++;
        }
        else if ([input characterAtIndex:1] == 'b' && errors == 0)
        {
            [resultingChord appendString:@"b"];
            compensation--;
            stringIndex++;
        }
        
        NSString *mods = [input substringWithRange:NSMakeRange((stringIndex + 1), (int)(input.length - 1 - stringIndex))];
        NSLog(@"Attempting to apply mod \"%@\"", mods);
        
        if ([mods isEqualToString:@"m"])
            keysToAdd[1] = 4;
        else if ([mods isEqualToString:@"7"])
            keysToAdd[3] = 11;
        else if ([mods isEqualToString:@"M7"])
            keysToAdd[3] = 12;
        else if ([mods isEqualToString:@"m7"]) {
            keysToAdd[1] = 4;
            keysToAdd[3] = 11;
        }
        else if ([mods isEqualToString:@"mM7"]) {
            keysToAdd[1] = 4;
            keysToAdd[3] = 12;
        }
        else if ([mods isEqualToString:@"dim"]) {
            keysToAdd[1] = 4;
            keysToAdd[2] = 7;
        }
        else if ([mods isEqualToString:@"dim7"]) {
            keysToAdd[1] = 4;
            keysToAdd[2] = 7;
            keysToAdd[3] = 10;
        }
        else if ([mods isEqualToString:@"m7b5"]) {
            keysToAdd[1] = 4;
            keysToAdd[2] = 7;
            keysToAdd[3] = 11;
        }
        else if ([mods isEqualToString:@"sus4"])
            keysToAdd[1] = 6;
        else if ([mods isEqualToString:@"add9"]){
            keysToAdd[1] = 3;
            keysToAdd[2] = 5;
            keysToAdd[3] = 8;
            
        }
        else if ([mods isEqualToString:@"6"])
            keysToAdd[3] = 10;
        else if ([mods isEqualToString:@"aug"])
            keysToAdd[2] = 9;
        else if ([mods isEqualToString:@"7sus4"]){
            keysToAdd[1] = 6;
            keysToAdd[3] = 11;
        }
        else if ([mods isEqualToString:@"m7b5"]){
            keysToAdd[2] = 7;
            keysToAdd[3] = 11;
        }
        
        
        else
            errors = 1;
        
        [resultingChord appendFormat:@"%@", mods];
        
    }
    
    // if the parsed chord has a match, the pressed keys are reset and a new chord is filled in.
    if (errors == 0)
    {
        [self reset];
        
        for (int i = 0; i < 4; i++)
            [self modifyChordWithThisKey:(keysToAdd[i] + compensation)];
    }
    
    // otherwise, an error is returned.
    else
    {
        [self reset];
        resultingChord = [NSMutableString stringWithString:@"Error"];
    }
    
    return resultingChord;
}

-(NSString*) intToPitch: (int) n
{
    NSString* output;
    switch (n) {
        case 1:     output = @"C";  break;
        case 2:     output = @"C#";  break;
        case 3:     output = @"D";  break;
        case 4:     output = @"Eb";  break;
        case 5:     output = @"E";  break;
        case 6:     output = @"F";  break;
        case 7:     output = @"F#";  break;
        case 8:     output = @"G";  break;
        case 9:     output = @"Ab";  break;
        case 10:     output = @"A";  break;
        case 11:     output = @"Bb";  break;
        case 12:     output = @"B";  break;
        case 13:     output = @"C";  break;
        case 14:     output = @"C#";  break;
        case 15:     output = @"D";  break;
        case 16:     output = @"Eb";  break;
        case 17:     output = @"E";  break;
        case 18:     output = @"F";  break;
        case 19:     output = @"F#";  break;
        case 20:     output = @"G";  break;
        case 21:     output = @"Ab";  break;
        case 22:     output = @"A";  break;
        case 23:     output = @"Bb";  break;
        case 24:     output = @"B";  break;
        default:    output = @"-"; break;
    }

    return output;
    
}

-(int) chordContentsAt: (int) n
{
    if (n > MAXCHORDLENGTH)
        n = -1;
    else if (n < 0)
        n = -1;
    
    return intKeys[n];
}

-(void) outputArray // used for testing only
{
    printf("intKeys[] is:\t\t");
    
    for (int i = 0; i < MAXCHORDLENGTH; i++)
        printf("%i\t" ,intKeys[i]);
    printf("\n");
    
    printf("diffKeys[] is:\t");
    
    for (int i = 0; i < MAXCHORDLENGTH; i++)
        printf("%i\t" ,diffKeys[i]);
    printf("\n");
}

-(void) reset
{
    count = 0;
    for (int i = 0; i < MAXCHORDLENGTH; i++)
        intKeys[i] = 99;
}

@end
