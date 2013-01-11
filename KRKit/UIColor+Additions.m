//
//  UIColor+Additions.m
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import "UIColor+Additions.h"

@implementation UIColor (Additions)

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

@end