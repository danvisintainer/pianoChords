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
}

- (id) init {
    
    self = [super init];
    
    if (self)
    {
        keySounds = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 24; i++)
        {
            
        }
        
        /*
        NSString *filePath1 = [[NSBundle mainBundle] pathForResource:@"p1" ofType:@"wav"];
        NSURL *fileURL1 = [[NSURL alloc] initFileURLWithPath:filePath1];
        self.p1player = [[AVAudioPlayer alloc]initWithContentsOfURL:fileURL1 error:nil];
        */
    }
    
    return self;

}

- (void) playTheKey: (int) n
{
    
}

@end
