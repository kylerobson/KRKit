//
//  CGGeometry+KRAdditions.h
//  KRKit
//
//  Created by Kyle Robson on 1/15/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

CGRect CGRectChop (CGRect rect, CGFloat amount, CGRectEdge edge);
CGRect CGRectGrow (CGRect rect, CGFloat amount, CGRectEdge edge);
CGRect CGRectWithSize (CGSize size);
CGPoint CGPointFloor(CGPoint point);
CGPoint CGRectCenterPoint (CGRect rect);
CGRect CGRectCenterInRect(CGRect containerRect, CGRect containedRect);
CGRect CGRectCenterVerticallyInRect(CGRect containerRect, CGRect containedRect, CGFloat originX);
CGRect CGRectCenterHorizontallyInRect(CGRect containerRect, CGRect containedRect, CGFloat originY);
CGPoint CGPointAdd(CGPoint p1, CGPoint p2);
CGPoint CGPointSubtract(CGPoint p1, CGPoint p2);