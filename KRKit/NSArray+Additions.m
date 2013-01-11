//
//  NSArray+Additions.m
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import "NSArray+Additions.h"

@implementation NSArray (Additions)

- (NSArray *)objectsOfClass:(Class)aClass
{
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(class == %@)", aClass]];
}

@end