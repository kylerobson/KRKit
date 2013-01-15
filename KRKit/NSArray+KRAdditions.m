//
//  NSArray+KRAdditions.m
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import "NSArray+KRAdditions.h"

@implementation NSArray (KRAdditions)

- (NSArray *)objectsOfClass:(Class)aClass
{
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(class == %@)", aClass]];
}

- (NSArray *)reversedArray
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator) {
        [array addObject:element];
    }
    return array;
}

@end