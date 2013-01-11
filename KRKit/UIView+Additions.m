//
//  UIView+Additions.m
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

- (void)removeAllSubviews
{
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (NSArray *)allSubviews
{
    NSMutableArray *subviews = [NSMutableArray arrayWithArray:self.subviews];
    for (UIView *subview in self.subviews) {
        [subviews addObjectsFromArray:[subview allSubviews]];
    }
    return subviews;
}

@end