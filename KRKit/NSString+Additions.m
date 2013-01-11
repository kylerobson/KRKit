//
//  NSString+Additions.m
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (BOOL)hasUsefulLength
{
    return (self != nil && self.trimmedString.length > 0);
}

- (NSString *)trimmedString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (BOOL)isValidEmail
{
    NSString *laxRegex = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", laxRegex];
    return [emailTest evaluateWithObject:self];
}

+ (NSString *)uniqueString
{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    NSString *uuidStr = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return uuidStr;
}

- (NSString *)stringByAppendingPathComponentToDocumentsDirectory
{
    return [[NSString documentsDirectory] stringByAppendingPathComponent:self];
}

+ (NSString *)documentsDirectory
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

- (NSString *)stringByAppendingPathComponentToBundleDirectory
{
    return [[NSString bundleDirectory] stringByAppendingPathComponent:self];
}

+ (NSString *)bundleDirectory
{
    return [[NSBundle mainBundle] resourcePath];
}

+ (NSString *)cachesDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSString *)stringByAppendingPathComponentToCachesDirectory
{
    return [[NSString cachesDirectory] stringByAppendingPathComponent:self];
}

- (NSString *)stringByRemovingHTML
{
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound) {
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    }
    return s;
}

- (NSNumber *)intNumber
{
    return [NSNumber numberWithInt:self.intValue];
}

- (UIColor *)colorValue
{
    CGFloat alpha = 1.0f;
    NSArray *colorComponents = [self componentsSeparatedByString:@","];
    CGFloat red = 0.0f;
    CGFloat green = 0.0f;
    CGFloat blue = 0.0f;
    if (colorComponents.count >= 3) {
        red = [colorComponents[0] floatValue] / 255.0f;
        green = [colorComponents[1] floatValue] / 255.0f;
        blue = [colorComponents[2] floatValue] / 255.0f;
    }
    if (colorComponents.count > 3) {
        alpha = [colorComponents[3] floatValue];
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (BOOL)isEqualCaseInsensitiveToString:(NSString *)string
{
    return [self.lowercaseString isEqualToString:string.lowercaseString];
}

- (NSDictionary *)queryDictionary
{
    NSArray *urlParts = [self componentsSeparatedByString:@"?"];
    if (urlParts.count > 0) {
        NSMutableDictionary *queryDictionary = [NSMutableDictionary dictionary];
        NSString *queryString = urlParts[urlParts.count - 1];
        NSArray *queryKeysAndValues = [queryString componentsSeparatedByString:@"&"];
        for (NSString *keyValueString in queryKeysAndValues)
        {
            NSArray *keyValueParts = [keyValueString componentsSeparatedByString:@"="];
            NSString *key = keyValueParts[0];
            NSString *value = keyValueParts[1];
            
            [queryDictionary setObject:value forKey:key];
        }
        return [queryDictionary copy];
    }
    return nil;
}

@end