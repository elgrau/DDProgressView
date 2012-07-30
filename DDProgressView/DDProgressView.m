//
//  DDProgressView.m
//  DDProgressView
//
//  Created by Damien DeVille on 3/13/11.
//  Copyright 2011 Snappy Code. All rights reserved.
//

#import "DDProgressView.h"

#define kProgressBarHeight  22.0f
#define kProgressBarWidth	160.0f

@interface DDProgressView()

@property (nonatomic, strong) DDProgressBar *defaultProgressBar;
@property (nonatomic, strong) NSMutableDictionary *progressBars;
@property (nonatomic, strong) NSMutableArray *progressBarsKeys;

-(void)setupView;

@end

@implementation DDProgressView
@synthesize defaultProgressBar = _defaultProgressBar;
@synthesize progressBars = _progressBars;
@synthesize progressBarsKeys = _progressBarsKeys;
@synthesize outerColor = _outerColor;
@synthesize emptyColor = _emptyColor;
@synthesize useRoundedCorners = _useRoundedCorners;


- (id)init
{
	return [self initWithFrame: CGRectZero] ;
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame: frame] ;
	if (self)
	{
        [self setupView];
	}
	return self ;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder] ;
	if (self)
	{
        [self setupView];
	}
	return self ;
}

-(void)setupView
{
    _defaultProgressBar = [[DDProgressBar alloc] init];
    _progressBars = [NSMutableDictionary dictionary];
    _progressBarsKeys = [NSMutableArray array];
    
    _defaultProgressBar.color = [UIColor lightGrayColor];
    
    self.backgroundColor = [UIColor clearColor] ;
    self.outerColor = [UIColor lightGrayColor] ;
    self.emptyColor = [UIColor clearColor] ;
    self.useRoundedCorners = NO;
    if (self.frame.size.width == 0.0f) {
        CGRect frame = self.frame;
        frame.size.width = kProgressBarWidth ;
        self.frame = frame;
    }        
}


-(void)addProgressBar:(DDProgressBar *)progressBar
{
    if (progressBar && [progressBar.name length]>0 && ![[_progressBars allKeys] containsObject:progressBar.name]) {
        [_progressBars setObject:progressBar forKey:progressBar.name];
        [_progressBarsKeys addObject:progressBar.name];
        
        [self setNeedsDisplay];
    } 
}

-(void)removeProgressBarWithName:(NSString *)name
{
    DDProgressBar *progressBar = [_progressBars objectForKey:name];
    
    if (progressBar) {
        [_progressBars removeObjectForKey:name];
        [_progressBarsKeys removeObject:name];
    } 
    
    [self setNeedsDisplay];
}

-(float)minValue
{
    return _defaultProgressBar.minValue;
}

- (void)setMinValue:(float)minValue
{
    _defaultProgressBar.minValue = minValue;
}

-(float)maxValue
{
    return _defaultProgressBar.maxValue;
}

- (void)setMaxValue:(float)maxValue
{
    _defaultProgressBar.maxValue = maxValue;
}

-(float)progress
{
    return _defaultProgressBar.progress;
}

- (void)setProgress:(float)progress
{
    _defaultProgressBar.progress = progress;
    
	[self setNeedsDisplay] ;
}

- (void)setProgress:(float)progress forProgressBarWithName:(NSString *)name
{
    DDProgressBar *progressBar = [_progressBars objectForKey:name];
    
    if (progressBar) {
        progressBar.progress = progress;        
        [self setNeedsDisplay] ;
    }
}

-(void)increaseProgress:(float)progress
{
    [_defaultProgressBar increaseProgress:progress];
    
  	[self setNeedsDisplay] ;
}

-(void)increaseProgress:(float)progress forProgressBarWithName:(NSString *)name
{
    DDProgressBar *progressBar = [_progressBars objectForKey:name];
    
    if (progressBar) {
        [progressBar increaseProgress:progress];        
        [self setNeedsDisplay] ;
    }
}



- (void)setInnerColor:(UIColor *)color
{
    _defaultProgressBar.color = color;    
	[self setNeedsDisplay] ;
}

- (void)setFrame:(CGRect)frame
{
	// we set the height ourselves since it is fixed
	frame.size.height = kProgressBarHeight ;
	[super setFrame: frame] ;
}

- (void)setBounds:(CGRect)bounds
{
	// we set the height ourselves since it is fixed
	bounds.size.height = kProgressBarHeight ;
	[super setBounds: bounds] ;
}

- (void)drawProgressBar:(DDProgressBar *)progressBar withRect:(CGRect)rect andRadius:(CGFloat)radius inContext:(CGContextRef)context
{
    [progressBar.color setFill] ;
    
    CGContextBeginPath(context) ;
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMidY(rect)) ;
    CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMidX(rect), CGRectGetMinY(rect), radius) ;
    CGContextAddArcToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMidY(rect), radius) ;
    CGContextAddArcToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMidX(rect), CGRectGetMaxY(rect), radius) ;
    CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMidY(rect), radius) ;
    CGContextClosePath(context) ;
    CGContextFillPath(context) ;
    
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext() ;
	
	// save the context
	CGContextSaveGState(context) ;
	
	// allow antialiasing
	CGContextSetAllowsAntialiasing(context, TRUE) ;
	
	// we first draw the outter rounded rectangle
	rect = CGRectInset(rect, 1.0f, 1.0f) ;
	CGFloat radius = self.useRoundedCorners? 0.5f * rect.size.height : 0 ;
    
	[_outerColor setStroke] ;
	CGContextSetLineWidth(context, 2.0f) ;
	
	CGContextBeginPath(context) ;
	CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMidY(rect)) ;
	CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMidX(rect), CGRectGetMinY(rect), radius) ;
	CGContextAddArcToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMidY(rect), radius) ;
	CGContextAddArcToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMidX(rect), CGRectGetMaxY(rect), radius) ;
	CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMidY(rect), radius) ;
	CGContextClosePath(context) ;
	CGContextDrawPath(context, kCGPathStroke) ;
    
    // draw the empty rounded rectangle (shown for the "unfilled" portions of the progress
    rect = CGRectInset(rect, 3.0f, 3.0f) ;
	radius = self.useRoundedCorners? 0.5f * rect.size.height : 0 ;
	
	[_emptyColor setFill] ;
	
	CGContextBeginPath(context) ;
	CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMidY(rect)) ;
	CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMidX(rect), CGRectGetMinY(rect), radius) ;
	CGContextAddArcToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMidY(rect), radius) ;
	CGContextAddArcToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMidX(rect), CGRectGetMaxY(rect), radius) ;
	CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMidY(rect), radius) ;
	CGContextClosePath(context) ;
	CGContextFillPath(context) ;
    
    rect.size.width *= [_defaultProgressBar valueForDrawing] ;
    if (rect.size.width < 2 * radius)
        rect.size.width = 2 * radius ;

    if (_defaultProgressBar.progress > _defaultProgressBar.minValue) {    
        [self drawProgressBar:_defaultProgressBar withRect:rect andRadius:radius inContext:context];
    }
        
    if (_progressBars.count > 0) {        
        NSEnumerator *keyEnumerator = [_progressBarsKeys objectEnumerator];
        for (NSString *key in keyEnumerator) {
            
            DDProgressBar *progressBar = [_progressBars objectForKey:key];
            
            if (progressBar.progress > progressBar.minValue) {            
                rect.size.width *= [progressBar valueForDrawing] ;
                if (rect.size.width < 2 * radius)
                    rect.size.width = 2 * radius ;
                
                [self drawProgressBar:progressBar withRect:rect andRadius:radius inContext:context];
            }
        }
    }
    
    // restore the context
    CGContextRestoreGState(context) ;
}

@end
