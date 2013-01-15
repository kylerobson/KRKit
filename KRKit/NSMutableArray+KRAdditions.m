//
//  NSMutableArray+KRAdditions.m
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import "NSMutableArray+KRAdditions.h"

@implementation NSMutableArray (KRAdditions)

- (NSMutableArray *)objectsOfClass:(Class)aClass
{
    NSArray *array = [self copy];
    return [NSMutableArray arrayWithArray:[array objectsOfClass:aClass]];
}

- (void)reverse
{
    if (self.count > 0) {
        NSUInteger i = 0;
        NSUInteger j = self.count - 1;
        while (i < j) {
            [self exchangeObjectAtIndex:i withObjectAtIndex:j];
            i++;
            j--;
        }
    }
}

@end