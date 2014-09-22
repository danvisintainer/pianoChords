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
{
    NSMutableArray *keySounds;
    AVAudioPlayer *keyPlayer;
}

- (id) init {
    
    self = [super init];
    
    if (self)
    {
        
        keySounds = [NSMutableArray arrayWithCapacity:24];
        
        for (int i = 1; i <= 24; i++)
        {
            NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"p%i", i] ofType:@"mp3"];
            NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:filePath];
            AVAudioPlayer *p = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
            
            [p prepareToPlay];
            [keySounds addObject:(id)p];
        }
    }
    
    return self;

}

- (void) playTheKey: (int) n
{
    keyPlayer = [keySounds objectAtIndex:(n-1)];
    [keyPlayer play];
}

@end
