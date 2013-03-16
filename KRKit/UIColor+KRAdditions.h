//
//  UIColor+KRAdditions.h
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (KRAdditions)

+ (UIColor *)randomColor;
- (CGFloat)componentAtIndex:(NSUInteger)index;
- (CGFloat)alphaComponent;
- (CGFloat)blueComponent;
- (CGFloat)greenComponent;
- (CGFloat)redComponent;
- (UIColor *)colorByMultiplyingByRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (UIColor *)colorByMultiplyingByRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha lowerLimit:(CGFloat)lowerLimit upperLimit:(CGFloat)upperLimit;
- (BOOL)red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha;
- (CGColorSpaceModel)colorSpaceModel;
@end