//
//  NSUserDefaults+KRAdditions.h
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (KRAdditions)

- (id)valueForKey:(NSString *)key defaulValue:(id)defaultValue;

@end