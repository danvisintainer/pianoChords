//
//  ViewController.h
//  PianoChordsCocoa
//
//  Created by Dan Visintainer on 11/19/13.
//  Copyright (c) 2013 Dan Visintainer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *chordDisplay;

-(IBAction) tapKey: (UIButton *) sender;

@end
