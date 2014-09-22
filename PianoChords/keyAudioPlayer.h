//
//  keyAudioPlayer.h
//  PianoChords
//
//  Created by Dan Visintainer on 9/21/14.
//  Copyright (c) 2014 Dan Visintainer. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface keyAudioPlayer : AVAudioEngine


- (void) playTheKey: (int) n;

@end
