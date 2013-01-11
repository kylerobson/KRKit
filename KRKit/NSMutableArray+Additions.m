//
//  NSMutableArray+Additions.m
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import "NSMutableArray+Additions.h"

@implementation NSMutableArray (Additions)

- (NSMutableArray *)objectsOfClass:(Class)aClass
{
    NSArray *array = [self copy];
    return [NSMutableArray arrayWithArray:[array objectsOfClass:aClass]];
}

@end