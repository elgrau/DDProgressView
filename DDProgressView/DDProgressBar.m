//
//  DDProgressBar.m
//  DDProgressView
//
//  Created by Miguel Ángel Grau Martínez on 26/07/12.
//  Copyright (c) 2012 Acrossair. All rights reserved.
//

#import "DDProgressBar.h"

@implementation DDProgressBar
@synthesize color = _color;
@synthesize progress = _progress;


-(void)setProgress:(float)progress
{
    if (progress > 1.0f)
		progress = 1.0f ;
	if (progress < 0.0f)
		progress = 0.0f ;
    
    _progress = progress;

}

@end
