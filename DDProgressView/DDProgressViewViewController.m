//
//  DDProgressViewViewController.m
//  DDProgressView
//
//  Created by Damien DeVille on 3/13/11.
//  Copyright 2011 Snappy Code. All rights reserved.
//

#import "DDProgressViewViewController.h"
#import "DDProgressView.h"
#import "DDProgressBar.h"

@interface DDProgressViewViewController() {
    float progressValues[3];
}
@end

@implementation DDProgressViewViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning] ;
}

- (void)viewDidLoad
{
    progressValues[0] = 0.0f;
    progressValues[1] = 0.0f;
    progressValues[2] = 0.0f;
    
    progressDir = 1 ;
    
    [super viewDidLoad] ;
    
	[self.view setBackgroundColor: [UIColor blackColor]] ;
	
	progressView = [[DDProgressView alloc] initWithFrame: CGRectMake(20.0f, 140.0f, self.view.bounds.size.width-40.0f, 0.0f)] ;
    progressView.useRoundedCorners = YES;
	[progressView setOuterColor: [UIColor grayColor]];
	[progressView setInnerColor: [UIColor lightGrayColor]] ;

    DDProgressBar *secondProgressBar = [[DDProgressBar alloc] initWithName:@"Second" color:[UIColor cyanColor] minValue:0.0 andMaxValue:100.0];
    
    DDProgressBar *thirdProgressBar = [[DDProgressBar alloc] initWithName:@"Third" color:[UIColor redColor] minValue:0.0 andMaxValue:200.0];
        
    [progressView addProgressBar:secondProgressBar];
    [progressView addProgressBar:thirdProgressBar];
        
	[self.view addSubview: progressView] ;
    
    
    progressView2 = [[DDProgressView alloc] initWithFrame: CGRectMake(20.0f, 180.0f, self.view.bounds.size.width-40.0f, 0.0f)] ;
    [progressView2 setOuterColor: [UIColor clearColor]] ;
    [progressView2 setInnerColor: [UIColor lightGrayColor]] ;
    [progressView2 setEmptyColor: [UIColor darkGrayColor]] ;
    [self.view addSubview: progressView2] ;
    
	
	// set a timer that updates the progress
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval: 0.03f target: self selector: @selector(updateProgress) userInfo: nil repeats: YES] ;
	[timer fire] ;
}

- (void)updateProgress
{
    progressValues[0] += (0.01f * progressDir);
    progressValues[1] += (0.5f * progressDir);
    progressValues[2] += (1 * progressDir);
    
	progressView.progress = progressValues[0];
    [progressView setProgress:progressValues[1] forProgressBarWithName:@"Second"] ;
    //[progressView setProgress:progressValues[2] forProgressBarWithName:@"Third"] ;
    [progressView increaseProgress:(1 * progressDir) forProgressBarWithName:@"Third"];
    
    progressView2.progress = progressValues[0];
    
    if (progressValues[0] > progressView.maxValue || progressValues[0] < progressView.minValue)
        progressDir *= -1 ;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload] ;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
