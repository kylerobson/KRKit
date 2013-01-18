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

CGSize CGSizeFloor(CGSize size)
{
    return (CGSize) { floorf(size.width), floorf(size.height) };
}

CGRect CGRectFloor(CGRect rect)
{
    return (CGRect) { CGPointFloor(rect.origin), CGSizeFloor(rect.size) };
}

CGPoint CGRectCenterPoint(CGRect rect)
{
    return CGPointMake(CGRectGetMinX(rect) + (CGRectGetWidth(rect) / 2.0f), CGRectGetMinY(rect) + (CGRectGetHeight(rect) / 2.0f));
}

CGRect CGRectCenterAndFloor(CGRect containerRect, CGRect containedRect)
{
    CGPoint point = CGPointMake((containerRect.size.width - containedRect.size.width) / 2.0f, (containerRect.size.height - containedRect.size.height) / 2.0f);
    return CGRectFloor((CGRect) { point, containedRect.size });
}

CGRect CGRectCenterAndFloorHorizontally(CGRect containerRect, CGRect containedRect, CGFloat originY)
{
    CGRect rect = CGRectCenterAndFloor(containerRect, containedRect);
    rect.origin.y = originY;
    return rect;
}

CGRect CGRectCenterAndFloorVertically(CGRect containerRect, CGRect containedRect, CGFloat originX)
{
    CGRect rect = CGRectCenterAndFloor(containerRect, containedRect);
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