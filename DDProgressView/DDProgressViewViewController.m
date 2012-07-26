//
//  DDProgressViewViewController.m
//  DDProgressView
//
//  Created by Damien DeVille on 3/13/11.
//  Copyright 2011 Snappy Code. All rights reserved.
//

#import "DDProgressViewViewController.h"
#import "DDProgressView.h"

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
    
    [progressView addProgressBarWithName:@"Second" andColor:[UIColor cyanColor] withProgress:progressValues[1]];
    [progressView addProgressBarWithName:@"Third" andColor:[UIColor redColor] withProgress:progressValues[2]];
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
    progressValues[1] += (0.005f * progressDir);
    progressValues[2] += (0.003f * progressDir);
    
	[progressView setProgress:progressValues[0]];
    [progressView setProgress:progressValues[1] forProgressBarWithName:@"Second"] ;
    [progressView setProgress:progressValues[2] forProgressBarWithName:@"Third"] ;
    
    [progressView2 setProgress: progressValues[0]];
    
    if (progressValues[0] > 1 || progressValues[0] < 0)
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
