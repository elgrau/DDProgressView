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

@interface DDProgressView : UIView

//@property (nonatomic) UIColor *innerColor ;
@property (nonatomic) UIColor *outerColor ;
@property (nonatomic) UIColor *emptyColor ;
//@property (nonatomic) float progress ;
@property (nonatomic) BOOL useRoundedCorners ;


-(void)addProgressBarWithName:(NSString *)name andColor:(UIColor *)color withProgress:(float)progress;
-(void)removeProgressBarWithName:(NSString *)name;
- (void)setProgress:(float)progress forProgressBarWithName:(NSString *)name;
- (void)setProgress:(float)progress;
- (void)setInnerColor:(UIColor *)color;

@end
