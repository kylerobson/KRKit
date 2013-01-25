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

@end