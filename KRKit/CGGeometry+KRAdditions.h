//
//  CGGeometry+KRAdditions.h
//  KRKit
//
//  Created by Kyle Robson on 1/15/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGGeometry+KRAdditions.h"

CGRect CGRectChop(CGRect rect, CGFloat amount, CGRectEdge edge);
CGRect CGRectGrow(CGRect rect, CGFloat amount, CGRectEdge edge);
CGRect CGRectWithSize(CGSize size);
CGPoint CGPointFloor(CGPoint point);
CGSize CGSizeFloor(CGSize size);
CGRect CGRectFloor(CGRect rect);
CGPoint CGRectCenterPoint(CGRect rect);
CGRect CGRectCenterAndFloor(CGRect containerRect, CGRect containedRect);
CGRect CGRectCenterAndFloorHorizontally(CGRect containerRect, CGRect containedRect, CGFloat originY);
CGRect CGRectCenterAndFloorVertically(CGRect containerRect, CGRect containedRect, CGFloat originX);
CGPoint CGPointAdd(CGPoint p1, CGPoint p2);
CGPoint CGPointSubtract(CGPoint p1, CGPoint p2);
CGRect CGRectShiftedByPoint(CGRect rect, CGPoint point);
CGFloat CGRectGetYForSiblingCentering(CGRect siblingRect, CGRect rectToCenter);
CGFloat CGRectGetXForSiblingCentering(CGRect siblingRect, CGRect rectToCenter);