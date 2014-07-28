//
//  ViewController.m
//  PianoChordsCocoa
//
//  Created by Dan Visintainer on 11/19/13.
//  Copyright (c) 2013 Dan Visintainer. All rights reserved.
//

#import "ViewController.h"
#import "Chord.h"

@implementation ViewController
{
    NSString *currentChordString;
    Chord *chord;
}

@synthesize chordDisplay;

- (void) viewDidLoad
{
    chord = [[Chord alloc] init];
    currentChordString = [NSMutableString stringWithCapacity:10];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"PianoChords initalized.");
}

/*
 -(IBAction) tapKey: (UIButton *) sender;
{
    if (![chord isKeyPressed:sender.tag])
    {
        [chord addKey:sender.tag];
        [d drawCircle];
    }
    else
    {
        [chord deleteKey:sender.tag];
    }
    
    chordDisplay.text = [chord calculate];
    
}
*/
//---fired when the user finger(s) touches the screen---
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:touch.view];
    NSLog(@"x=%f", point.x);
    NSLog(@"y=%f", point.y);
    
    [chord processTheseCoords:point.x :point.y];
    chordDisplay.text = [chord calculate];
}

/*
-(void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event
{
    //---get all touches on the screen---
    NSSet *allTouches = [event allTouches];
    
    //---compare the number of touches on the screen---
    switch ([allTouches count])
    {
            //---single touch---
        case 1: {
            
            //---get info of the touch---
            UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
            CGPoint point = [touch locationInView:self];
            NSLog(@"x=%f", point.x);
            NSLog(@"y=%f", point.y);
            
            //---compare the touches---
            switch ([touch tapCount])
            {
                    //---single tap---
                case 1: {
                    NSLog(@"Single tap");
                } break;
                    
                    //---double tap---
                case 2: {
                    NSLog(@"Double tap");
                    
                } break;
                    
            }
            
        }  break;
    }
}
*/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
