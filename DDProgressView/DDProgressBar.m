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
@synthesize name = _name;
@synthesize progress = _progress;
@synthesize maxValue = _maxValue;
@synthesize minValue = _minValue;


-(id)init {
    return [self initWithName:@"" color:[UIColor grayColor] minValue:0.0f andMaxValue:1.0f];
}


-(id)initWithName:(NSString *)name {
    return [self initWithName:name color:[UIColor grayColor] minValue:0.0f andMaxValue:1.0f];
}

-(id)initWithName:(NSString *)name color:(UIColor *)color {
    return [self initWithName:name color:color minValue:0.0f andMaxValue:1.0f];
}

-(id)initWithName:(NSString *)name color:(UIColor *)color minValue:(CGFloat)minValue andMaxValue:(CGFloat)maxValue {
    self = [super init];
    
    if (self) {
        _name = name;
        _minValue = minValue;
        _maxValue = maxValue;
        _color = color;        
        _progress = minValue;        
    }
    return self;
}

-(void)setProgress:(float)progress
{
    if (progress > _maxValue)
		progress = _maxValue ;
	if (progress < _minValue)
		progress = _minValue ;
    
    _progress = progress;
}

-(CGFloat)valueForDrawing
{
    if (_maxValue > _minValue) {
        return (_progress - _minValue) / (_maxValue - _minValue);
    } else {
        return 0.0f;
    }
}

@end
