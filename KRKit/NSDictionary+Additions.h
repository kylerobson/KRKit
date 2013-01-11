//
//  NSDictionary+Additions.h
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Additions)

- (void)setValue:(id)value withNilConvertedToNullForKey:(id)key;
- (id)valueWithNullConvertedToNilForKey:(NSString *)key;

@end