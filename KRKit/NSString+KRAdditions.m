//
//  NSString+KRAdditions.m
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import "NSString+KRAdditions.h"
#import <GRMustache.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (KRAdditions)

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

- (NSString *)stringByAppendingPathComponentToCachesDirectory
{
    return [[NSString cachesDirectory] stringByAppendingPathComponent:self];
}

+ (NSString *)cachesDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSString *)stringByAppendingPathComponentToTemporaryDirectory
{
    return [[NSString temporaryDirectory] stringByAppendingPathComponent:self];
}

+ (NSString *)temporaryDirectory
{
    return NSTemporaryDirectory();
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
    return [self.lowercaseString.trimmedString isEqualToString:string.lowercaseString.trimmedString];
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

+ (void)stringWithContentsOfCachesFileNamed:(NSString *)name templateObject:(id)templateObject completion:(void (^)(NSString *stringFromFile))completion
{
    [self stringWithContentsOfFile:[name stringByAppendingPathComponentToCachesDirectory] templateObject:templateObject completion:completion];
}

+ (void)stringWithContentsOfBundleFileNamed:(NSString *)name templateObject:(id)templateObject completion:(void (^)(NSString *stringFromFile))completion
{
    [self stringWithContentsOfFile:[name stringByAppendingPathComponentToBundleDirectory] templateObject:templateObject completion:completion];
}

+ (void)stringWithContentsOfDocumentsFileNamed:(NSString *)name templateObject:(id)templateObject completion:(void (^)(NSString *stringFromFile))completion
{
    [self stringWithContentsOfFile:[name stringByAppendingPathComponentToDocumentsDirectory] templateObject:templateObject completion:completion];
}

+ (void)stringWithContentsOfFile:(NSString *)name templateObject:(id)templateObject completion:(void (^)(NSString *stringFromFile))completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *string = [NSString stringWithContentsOfFile:name encoding:NSUTF8StringEncoding error:NULL];
        if (templateObject != nil) {
            string = [GRMustacheTemplate renderObject:templateObject fromString:string error:NULL];
        }
        if (completion != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(string);
            });
        }
    });
}

- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];  
}

@end