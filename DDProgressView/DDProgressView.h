//
//  DDProgressView.h
//  DDProgressView
//
//  Created by Damien DeVille on 3/13/11.
//  Copyright 2011 Snappy Code. All rights reserved.
//

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#elif TARGET_OS_MAC
#import "AppKitCompatibility.h"
#endif
#import "DDProgressBar.h"

@interface DDProgressView : UIView

//@property (nonatomic) UIColor *innerColor ;
@property (nonatomic) UIColor *outerColor;
@property (nonatomic) UIColor *emptyColor;
@property (nonatomic) BOOL useRoundedCorners;
@property (nonatomic) float progress;
@property (nonatomic) float minValue;
@property (nonatomic) float maxValue;

-(void)addProgressBar:(DDProgressBar *)progressBar;
//-(void)addProgressBarWithName:(NSString *)name andColor:(UIColor *)color withProgress:(float)progress;
-(void)removeProgressBarWithName:(NSString *)name;
- (void)setProgress:(float)progress forProgressBarWithName:(NSString *)name;
- (void)setProgress:(float)progress;
- (void)setMinValue:(float)minValue;
- (void)setMaxValue:(float)maxValue;
- (void)setInnerColor:(UIColor *)color;

@end
