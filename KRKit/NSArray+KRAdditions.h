//
//  NSArray+KRAdditions.h
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (KRAdditions)

- (NSArray *)objectsOfClass:(Class)aClass;
- (NSArray *)reversedArray;

@end