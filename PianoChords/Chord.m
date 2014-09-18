//
//  Chord.m
//  PianoChordsCocoa
//
//  Created by Dan Visintainer on 11/23/13.
//  Copyright (c) 2013 Dan Visintainer. All rights reserved.
//

#import "Chord.h"
#import "Constants.h"

@implementation Chord

@synthesize keys;
@synthesize count;

-(id) init
{
    self = [super init];
    
    if (self)
    {
        keys = [[NSMutableArray alloc] init];
        count = 0;
        
        for (int i = 0; i < MAXCHORDLENGTH; i++)
            intKeys[i] = 99;
        
        for (int i = 0; i < MAXCHORDLENGTH; i++)
            diffKeys[i] = 99;
        
        NSLog(@"Chord class initialized.");
    }

    return self;
}

-(void) modifyChordWithThisKey: (int) key;
{
    if (![self isKeyPressed:key])   // if key has not already been pressed
    {
        NSLog(@"Adding key %i", key);
        
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
        [self outputArray];
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

-(void) sort
{
    [keys sortUsingSelector: @selector(compare:)];
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
    // int finalChord;
    NSString* output = @"";
    
    if (count == 0)
        output = @"-";
    else if (count == 1)
    {
        output = [self intToPitch:intKeys[0]];
    }
    
     else if (count == 2)
     {
        for (int i = 0; i < MAXCHORDLENGTH; i++)
            diffKeys[i] = intKeys[i] - rootDifference;
         
        output = [self intToPitch:diffKeys[0]];
        
        switch (diffKeys[1]) {   // case for a two-pitch cord. what is the SECOND key
            case 2:         output = [NSString stringWithFormat:@"%@M7", [self intToPitch:(diffKeys[1]+rootDifference)]];     break;
            case 3:         output = [NSString stringWithFormat:@"%@7", [self intToPitch:(diffKeys[1]+rootDifference)]];     break;
            case 4:         output = [NSString stringWithFormat:@"%@m", [self intToPitch:(diffKeys[0]+rootDifference)]];     break;
            case 5:         output = [NSString stringWithFormat:@"%@", [self intToPitch:(diffKeys[0]+rootDifference)]];     break;
            case 6:         output = [NSString stringWithFormat:@"%@", [self intToPitch:(diffKeys[1]+rootDifference)]];     break;
            case 7:         output = [NSString stringWithFormat:@"%@dim7", [self intToPitch:(diffKeys[0]+rootDifference)]];     break;
            case 8:         output = [NSString stringWithFormat:@"%@", [self intToPitch:(diffKeys[0]+rootDifference)]];     break;
            case 9:         output = [NSString stringWithFormat:@"%@", [self intToPitch:(diffKeys[1]+rootDifference)]];     break;
            case 10:        output = [NSString stringWithFormat:@"%@m", [self intToPitch:(diffKeys[1]+rootDifference)]];     break;
            case 11:        output = [NSString stringWithFormat:@"%@7", [self intToPitch:(diffKeys[0]+rootDifference)]];     break;
            case 12:        output = [NSString stringWithFormat:@"%@M7", [self intToPitch:(diffKeys[0]+rootDifference)]];     break;
        }
        
        NSLog(@"%@", keys);
    }
    
     else if (count == 3)
     {
         for (int i = 0; i < MAXCHORDLENGTH; i++)
             diffKeys[i] = intKeys[i] - rootDifference;
         
         output = [self intToPitch:diffKeys[0]];
         
         // assume root is C1 (pitches are compensated later)
         
         if (diffKeys[1] == 2)
         {
             if (diffKeys[2] == 11)
                 output = [NSString stringWithFormat:@"%@madd9", [self intToPitch:(diffKeys[2]+rootDifference)]];
             else
                 output = [NSString stringWithFormat:@"%@M7", [self intToPitch:(diffKeys[1]+rootDifference)]];
         }
         else if (diffKeys[1] == 3)
         {
             switch (diffKeys[2])
             {
                 case 6:    output = [NSString stringWithFormat:@"%@m7", [self intToPitch:(diffKeys[1]+rootDifference)]];       break;
                 case 8:    output = [NSString stringWithFormat:@"%@sus2", [self intToPitch:(diffKeys[0]+rootDifference)]];     break;
                 case 10:   output = [NSString stringWithFormat:@"%@m", [self intToPitch:(diffKeys[2]+rootDifference)]];        break;
                 case 11:   output = [NSString stringWithFormat:@"%@madd9", [self intToPitch:(diffKeys[2]+rootDifference)]];    break;
                 default:   output = [NSString stringWithFormat:@"%@7", [self intToPitch:(diffKeys[1]+rootDifference)]];        break;
             }
         }
         else if (diffKeys[1] == 4)
         {
             switch (diffKeys[2])
             {
                 case 7:    output = [NSString stringWithFormat:@"%@dim", [self intToPitch:(diffKeys[0]+rootDifference)]];       break;
                 case 9:    output = [NSString stringWithFormat:@"%@", [self intToPitch:(diffKeys[2]+rootDifference)]];     break;
                 case 10:   output = [NSString stringWithFormat:@"%@dim", [self intToPitch:(diffKeys[2]+rootDifference)]];        break;
                 case 11:   output = [NSString stringWithFormat:@"%@m7", [self intToPitch:(diffKeys[0]+rootDifference)]];    break;
                 case 12:   output = [NSString stringWithFormat:@"%@mM7", [self intToPitch:(diffKeys[0]+rootDifference)]];    break;
                 default:   output = [NSString stringWithFormat:@"%@m", [self intToPitch:(diffKeys[0]+rootDifference)]];        break;
             }
         }
         else if (diffKeys[1] == 5)
         {
             switch (diffKeys[2])
             {
                 case 9:    output = [NSString stringWithFormat:@"%@aug", [self intToPitch:(diffKeys[0]+rootDifference)]];     break;
                 case 10:   output = [NSString stringWithFormat:@"%@m", [self intToPitch:(diffKeys[2]+rootDifference)]];        break;
                 case 11:   output = [NSString stringWithFormat:@"%@7", [self intToPitch:(diffKeys[0]+rootDifference)]];    break;
                 case 12:   output = [NSString stringWithFormat:@"%@M7", [self intToPitch:(diffKeys[0]+rootDifference)]];    break;
                 default:   output = [NSString stringWithFormat:@"%@", [self intToPitch:(diffKeys[0]+rootDifference)]];        break;
             }
         }
         else if (diffKeys[1] == 6)
         {
             switch (diffKeys[2])
             {
                 case 8:    output = [NSString stringWithFormat:@"%@sus4", [self intToPitch:(diffKeys[0]+rootDifference)]];     break;
                 case 9:    output = [NSString stringWithFormat:@"%@m", [self intToPitch:(diffKeys[1]+rootDifference)]];     break;
                 case 11:   output = [NSString stringWithFormat:@"%@sus4", [self intToPitch:(diffKeys[1]+rootDifference)]];    break;
                 default:   output = [NSString stringWithFormat:@"%@", [self intToPitch:(diffKeys[1]+rootDifference)]];        break;
             }
         }
         else if (diffKeys[1] == 7)
         {
             switch (diffKeys[2])
             {
                 case 9:    output = [NSString stringWithFormat:@"%@7", [self intToPitch:(diffKeys[2]+rootDifference)]];     break;
                 case 11:   output = [NSString stringWithFormat:@"%@sus4", [self intToPitch:(diffKeys[1]+rootDifference)]];    break;
                 default:   output = [NSString stringWithFormat:@"%@dim7", [self intToPitch:(diffKeys[0]+rootDifference)]];        break;
             }
         }
         
         
     }
    
    return output;
}

-(int) parseTheString: (NSString*) input;
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
        
        if (input.length > 2)
        {
            NSString *mods = [input substringWithRange:NSMakeRange((stringIndex + 1), (int)(input.length - 1 - stringIndex))];
            
            // defaults are keysToAdd{1, 5, 8, 13};
            
            if ([mods isEqualToString:@"7"])
                keysToAdd[3] = 11;
            if ([mods isEqualToString:@"M7"])
                keysToAdd[3] = 12;
            if ([mods isEqualToString:@"m7"]) {
                keysToAdd[1] = 4;
                keysToAdd[3] = 11;
            }
            if ([mods isEqualToString:@"mM7"]) {
                keysToAdd[1] = 4;
                keysToAdd[3] = 12;
            }
            if ([mods isEqualToString:@"dim"]) {
                keysToAdd[1] = 4;
                keysToAdd[2] = 7;
            }
            if ([mods isEqualToString:@"dim7"]) {
                keysToAdd[1] = 4;
                keysToAdd[2] = 7;
                keysToAdd[3] = 10;
            }
            if ([mods isEqualToString:@"dim7b5"]) {
                keysToAdd[1] = 4;
                keysToAdd[2] = 7;
                keysToAdd[3] = 11;
            }
            if ([mods isEqualToString:@"sus4"])
                keysToAdd[1] = 6;
            if ([mods isEqualToString:@"add9"])
                keysToAdd[3] = 15;
            if ([mods isEqualToString:@"6"])
                keysToAdd[3] = 10;
            if ([mods isEqualToString:@"aug"])
                keysToAdd[2] = 9;
            if ([mods isEqualToString:@"7sus4"]){
                keysToAdd[1] = 6;
                keysToAdd[3] = 11;
            }
            
        }
    }
    
    if (errors == 0)
    {
        NSLog(@"Parse completed without errors. The resulting chord is %@.", resultingChord);
        [self reset];
        
        for (int i = 0; i < 4; i++)
            [self modifyChordWithThisKey:(keysToAdd[i] + compensation)];
    }
    else
        NSLog(@"There was a problem parsing the chord.");
    
    return errors;
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
