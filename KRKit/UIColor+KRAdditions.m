//
//  UIColor+KRAdditions.m
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import "UIColor+KRAdditions.h"
#import "KRKit.h"

@implementation UIColor (KRAdditions)

+ (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0f );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0f ) + 0.5f;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0f ) + 0.5f;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (CGFloat)redComponent
{
    return [self componentAtIndex:0];
}

- (CGFloat)greenComponent
{
    return [self componentAtIndex:1];
}

- (CGFloat)blueComponent
{
    return [self componentAtIndex:2];
}

- (CGFloat)alphaComponent
{
    return [self componentAtIndex:3];
}

// This method assumes going for an RGB index, but it handles monochrome as well
- (CGFloat)componentAtIndex:(NSUInteger)index
{
    CGColorSpaceModel colorSpaceModel = CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    switch (colorSpaceModel) {
        case kCGColorSpaceModelMonochrome:
        {
            if (index == 3) {
                return components[1];
            }
            return components[0];
        }
        case kCGColorSpaceModelRGB:
        {
            return components[index];
        }
        default:
        {
            break;
        }
    }
    return 0.0f;
}

- (UIColor *)colorByMultiplyingByRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    return [self colorByMultiplyingByRed:red green:green blue:blue alpha:alpha lowerLimit:0.0 upperLimit:1.0];
}

- (UIColor *)colorByMultiplyingByRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha lowerLimit:(CGFloat)lowerLimit upperLimit:(CGFloat)upperLimit
{
	CGFloat r,g,b,a;
	if (![self red:&r green:&g blue:&b alpha:&a]) {
        return nil;
    }
    #pragma clang diagnostic ignored "-Wshadow"
    UIColor *color = [UIColor colorWithRed:MAX(lowerLimit, MIN(upperLimit, r * red)) green:MAX(lowerLimit, MIN(upperLimit, g * green)) blue:MAX(lowerLimit, MIN(upperLimit, b * blue)) alpha:MAX(0.0f, MIN(1.0f, a * alpha))];
    return color;
}

- (BOOL)red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha
{
	const CGFloat *components = CGColorGetComponents(self.CGColor);
	
	CGFloat r,g,b,a;
	
	switch (self.colorSpaceModel) {
		case kCGColorSpaceModelMonochrome:
			r = g = b = components[0];
			a = components[1];
			break;
		case kCGColorSpaceModelRGB:
			r = components[0];
			g = components[1];
			b = components[2];
			a = components[3];
			break;
		default:	// We don't know how to handle this model
			return NO;
	}
	
	if (red) *red = r;
	if (green) *green = g;
	if (blue) *blue = b;
	if (alpha) *alpha = a;
	
	return YES;
}

- (CGColorSpaceModel)colorSpaceModel
{
	return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

@end