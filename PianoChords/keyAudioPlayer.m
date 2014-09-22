//
//  keyAudioPlayer.m
//  PianoChords
//
//  Created by Dan Visintainer on 9/21/14.
//  Copyright (c) 2014 Dan Visintainer. All rights reserved.
//

#import "keyAudioPlayer.h"
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>

@implementation keyAudioPlayer

- (id) init {
    
    self = [super init];
    
    if (self)
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"p1" ofType:@"wav"];
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:filePath];
        self.myPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileURL error:nil];
        [self.myPlayer play];
        NSLog(@"Chord class initialized.");
    }
    
    return self;

}

- (void) playTheKey: (int) n
{
    
}

@end
