//
//  CGGeometry+KRAdditions.m
//  KRKit
//
//  Created by Kyle Robson on 1/15/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import "CGGeometry+KRAdditions.h"

CGRect CGRectChop(CGRect rect, CGFloat amount, CGRectEdge edge)
{
    CGRect slice, remainder;
    CGRectDivide(rect, &slice, &remainder, amount, edge);
    
    return remainder;
}

CGRect CGRectGrow(CGRect rect, CGFloat amount, CGRectEdge edge)
{
    switch (edge) {
        case CGRectMinXEdge:
        {
            return CGRectMake(CGRectGetMinX(rect) - amount, CGRectGetMinY(rect), CGRectGetWidth(rect) + amount, CGRectGetHeight(rect));
        }
        case CGRectMinYEdge:
        {
            return CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect) - amount, CGRectGetWidth(rect), CGRectGetHeight(rect) + amount);
        }
        case CGRectMaxXEdge:
        {
            return CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect) + amount, CGRectGetHeight(rect));
        }
        case CGRectMaxYEdge:
        {
            return CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), CGRectGetHeight(rect) + amount);
        }
        default:
        {
            NSCAssert(NO, @"Unrecognized CGRectEdge %i", (int)edge);
            return CGRectZero;
        }
    }
}

CGRect CGRectWithSize(CGSize size)
{
    return (CGRect) { CGPointZero, size };
}

CGPoint CGPointFloor(CGPoint point)
{
    return CGPointMake(floorf(point.x), ceilf(point.y));
}

CGPoint CGRectCenterPoint(CGRect rect)
{
    return CGPointMake(CGRectGetMinX(rect) + (CGRectGetWidth(rect) / 2), CGRectGetMinY(rect) + (CGRectGetHeight(rect) / 2));
}

CGRect CGRectCenterInRect(CGRect containerRect, CGRect containedRect)
{
    return (CGRect) { CGRectCenterPoint(containedRect), containedRect.size };
}

CGRect CGRectCenterHorizontallyInRect(CGRect containerRect, CGRect containedRect, CGFloat originY)
{
    CGRect rect = (CGRect) { CGRectCenterPoint(containedRect), containedRect.size };
    rect.origin.y = originY;
    return rect;
}

CGRect CGRectCenterVerticallyInRect(CGRect containerRect, CGRect containedRect, CGFloat originX)
{
    CGRect rect = (CGRect) { CGRectCenterPoint(containedRect), containedRect.size };
    rect.origin.x = originX;
    return rect;
}

CGPoint CGPointAdd(CGPoint p1, CGPoint p2)
{
    return CGPointMake(p1.x + p2.x, p1.y + p2.y);
}

CGPoint CGPointSubtract(CGPoint p1, CGPoint p2)
{
    return CGPointMake(p1.x - p2.x, p1.y - p2.y);
}

CGRect CGRectShiftedByPoint(CGRect rect, CGPoint point)
{
    return (CGRect) { CGPointAdd(rect.origin, point), rect.size };
}