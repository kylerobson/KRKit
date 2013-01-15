//
//  NSString+KRAdditions.h
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (KRAdditions)

- (BOOL)hasUsefulLength;
- (NSString *)trimmedString;
- (BOOL)isValidEmail;
+ (NSString *)uniqueString;
- (NSString *)stringByAppendingPathComponentToDocumentsDirectory;
+ (NSString *)documentsDirectory;
- (NSString *)stringByAppendingPathComponentToBundleDirectory;
+ (NSString *)bundleDirectory;
+ (NSString *)cachesDirectory;
- (NSString *)stringByAppendingPathComponentToCachesDirectory;
- (NSString *)stringByRemovingHTML;
- (NSNumber *)intNumber;
- (UIColor *)colorValue;
- (BOOL)isEqualCaseInsensitiveToString:(NSString *)string;
- (NSDictionary *)queryDictionary;

@end