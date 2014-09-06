//
//  CircleView.h
//  PianoChords
//
//  Created by Dan Visintainer on 8/28/14.
//  Copyright (c) 2014 Dan Visintainer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView
{
    NSMutableArray *totalCircles;
}

- (void)drawCircle;

@property (strong, nonatomic) IBOutlet UILabel *chordDisplay;
@property (strong, nonatomic) IBOutlet UIButton *clearButton;

-(IBAction) reset;

@end
