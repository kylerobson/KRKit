//
//  NSDictionary+KRAdditions.m
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import "NSDictionary+KRAdditions.h"
#import "KRKit.h"

@implementation NSDictionary (KRAdditions)

- (void)setValue:(id)value withNilConvertedToNullForKey:(id)key
{
    [self setValue:(value ?: [NSNull null]) forKey:key];
}

- (id)valueWithNullConvertedToNilForKey:(NSString *)key
{
    id value = self[key];
    return (value != [NSNull null] ? value : nil);
}

@end