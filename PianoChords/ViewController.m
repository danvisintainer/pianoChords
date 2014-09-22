//
//  ViewController.m
//  PianoChordsCocoa
//
//  Created by Dan Visintainer on 11/19/13.
//  Copyright (c) 2013 Dan Visintainer. All rights reserved.
//
#define MINRADIUS 10
#define MAXRADIUS 30

#import "ViewController.h"
#import "CircleView.h"


@implementation ViewController


- (void) viewDidLoad
{
    
    totalCircles = [[NSMutableArray alloc] init];
    //CircleView *circleview = [[CircleView alloc] init];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
