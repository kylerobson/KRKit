//
//  NSUserDefaults+KRAdditions.m
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import "NSUserDefaults+KRAdditions.h"

@implementation NSUserDefaults (KRAdditions)

- (id)valueForKey:(NSString *)key defaulValue:(id)defaultValue
{
    id value = [self valueForKey:key];
    if (value == nil) {
        [[NSUserDefaults standardUserDefaults] setValue:defaultValue forKey:key];
        return defaultValue;
    }
    return value;
}

@end