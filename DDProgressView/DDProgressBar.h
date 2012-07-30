//
//  DDProgressBar.h
//  DDProgressView
//
//  Created by Miguel Ángel Grau Martínez on 26/07/12.
//  Copyright (c) 2012 Acrossair. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDProgressBar : NSObject

@property (nonatomic, copy) UIColor *color;
@property (nonatomic, copy) NSString *name;
@property (nonatomic) float progress;
@property (nonatomic) float maxValue;
@property (nonatomic) float minValue;


-(id)initWithName:(NSString *)name;
-(id)initWithName:(NSString *)name color:(UIColor *)color;
-(id)initWithName:(NSString *)name color:(UIColor *)color minValue:(CGFloat)minValue andMaxValue:(CGFloat)maxValue;
-(CGFloat)valueForDrawing;
-(void)increaseProgress:(float)progress;
@end
