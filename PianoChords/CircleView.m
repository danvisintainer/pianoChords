//
//  CircleView.m
//  PianoChords
//
//  Created by Dan Visintainer on 8/28/14.
//  Copyright (c) 2014 Dan Visintainer. All rights reserved.
//

#import "CircleView.h"
#import "iOSCircle.h"
#import "Chord.h"

@implementation CircleView
{
    NSString *currentChordString;
    Chord *chord;
}

@synthesize chordDisplay;
@synthesize chordToParse;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        chord = [[Chord alloc] init];
        currentChordString = [NSMutableString stringWithCapacity:10];
        totalCircles = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    }
    NSLog(@"CircleView initalized.");
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self drawCircle];
}

- (void)drawCircle {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 10.0);
    [[UIColor redColor] set];
    
    for (int i = 0; i < (MAXCHORDLENGTH); i++) {
        float x = 0;
        float y = 0;
        bool draw = false;
        switch ([chord chordContentsAt:i]) {
            case -1: break;
            case 1: x = 19; y = 184;    draw = true;    break;
            case 2: x = 37; y = 115;    draw = true;    break;
            case 3: x = 61; y = 184;    draw = true;    break;
            case 4: x = 83; y = 115;    draw = true;    break;
            case 5: x = 101; y = 184;    draw = true;    break;
            case 6: x = 143; y = 184;    draw = true;    break;
            case 7: x = 158; y = 115;    draw = true;    break;
            case 8: x = 185; y = 184;    draw = true;    break;
            case 9: x = 203; y = 115;    draw = true;    break;
            case 10: x = 223; y = 184;    draw = true;    break;
            case 11: x = 250; y = 115;    draw = true;    break;
            case 12: x = 265; y = 184;    draw = true;    break;
            case 13: x = 305; y = 184;    draw = true;    break;
            case 14: x = 323; y = 115;    draw = true;    break;
            case 15: x = 346; y = 184;    draw = true;    break;
            case 16: x = 370; y = 115;    draw = true;    break;
            case 17: x = 387; y = 184;    draw = true;    break;
            case 18: x = 428; y = 184;    draw = true;    break;
            case 19: x = 443; y = 115;    draw = true;    break;
            case 20: x = 469; y = 184;    draw = true;    break;
            case 21: x = 490; y = 115;    draw = true;    break;
            case 22: x = 508; y = 184;    draw = true;    break;
            case 23: x = 534; y = 115;    draw = true;    break;
            case 24: x = 549; y = 184;    draw = true;    break;
        }
        
        if (draw)
        {
            CGContextAddArc(context, x, y, 10, 0.0, M_PI * 2.0, YES);
            CGContextStrokePath(context);
        }
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // method called when the user touches the screen
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    if ([chordToParse isFirstResponder] && [touch view] != chordToParse) {
        [chordToParse resignFirstResponder];
    }
    else
    {
        NSLog(@"x=%f", point.x);
        NSLog(@"y=%f", point.y);
        
        [self processTheseCoords:point.x :point.y];
        chordDisplay.text = [chord calculate];
    }
}

-(void) processTheseCoords: (float)x : (float)y
{
    float whiteKeyLength = 40.25;
    
    int n = -1;
    
    if (y >= 126)   // if user pressed a white key...
    {
        n = (int)(x / whiteKeyLength);
        
        switch (n) {    // here, we get the corresponding raw scale value for the white keys pressed
            case 0:     n = 1;  break;
            case 1:     n = 3;  break;
            case 2:     n = 5;  break;
            case 3:     n = 6;  break;
            case 4:     n = 8;  break;
            case 5:     n = 10;  break;
            case 6:     n = 12;  break;
            case 7:     n = 13;  break;
            case 8:     n = 15;  break;
            case 9:     n = 17;  break;
            case 10:     n = 18;  break;
            case 11:     n = 20;  break;
            case 12:     n = 22;  break;
            case 13:     n = 24;  break;
            case 14:     n = -1;  break;
        }
        
    }
    else if (y < 126)   // if user pressed a black key
    {
        if (x >= 0 && x <= 60)          n = 2;
        else if (x >= 60 && x <= 120)   n = 4;
        else if (x >= 120 && x <= 180)   n = 7;
        else if (x >= 180 && x <= 226)   n = 9;
        else if (x >= 226 && x <= 286)   n = 11;
        
        else if (x >= 286 && x <= 345)     n = 14;
        else if (x >= 345 && x <= 410)   n = 16;
        else if (x >= 410 && x <= 465)   n = 19;
        else if (x >= 465 && x <= 511)   n = 21;
        else if (x >= 511 && x <= 567)   n = 23;
    }
    else
        n = -1;
    
    [self setNeedsDisplay];
    [chord modifyChordWithThisKey:n];
}

-(IBAction) textFieldReturn: (id) sender
{
    // when the "enter" key on the keyboard is pressed
    
    chordDisplay.text = [chord parseTheString:chordToParse.text];
    [sender resignFirstResponder];
    [self setNeedsDisplay];
}

-(IBAction) reset
{
    // clears the chord as well as the circles on the screen.
    
    [chord reset];
    [self setNeedsDisplay];
    chordDisplay.text = @"-";
}

@end
