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
#import "KRKit.h"

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
            [GRMustache preventNSUndefinedKeyExceptionAttack];
            string = [GRMustacheTemplate renderObject:templateObject fromString:string error:NULL];
        }
        if (completion != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(string);
            });
        }
    });
}

+ (NSString *)stringWithContentsOfCachesFileNamed:(NSString *)name templateObject:(id)templateObject
{
    return [self stringWithContentsOfFile:[name stringByAppendingPathComponentToCachesDirectory] templateObject:templateObject];
}

+ (NSString *)stringWithContentsOfBundleFileNamed:(NSString *)name templateObject:(id)templateObject
{
    return [self stringWithContentsOfFile:[name stringByAppendingPathComponentToBundleDirectory] templateObject:templateObject];
}

+ (NSString *)stringWithContentsOfDocumentsFileNamed:(NSString *)name templateObject:(id)templateObject
{
    return [self stringWithContentsOfFile:[name stringByAppendingPathComponentToDocumentsDirectory] templateObject:templateObject];
}

+ (NSString *)stringWithContentsOfFile:(NSString *)name templateObject:(id)templateObject
{
    NSString *string = [NSString stringWithContentsOfFile:name encoding:NSUTF8StringEncoding error:NULL];
    [GRMustache preventNSUndefinedKeyExceptionAttack];
    return [GRMustacheTemplate renderObject:templateObject fromString:string error:NULL];
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

- (NSString *)fileMD5
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:self];
    if (handle == nil) {
        return nil;
    }
    
    CC_MD5_CTX md5;
    
    CC_MD5_Init(&md5);
    
    BOOL done = NO;
    while (!done) {
        NSData *fileData = [handle readDataOfLength:4096];
        CC_MD5_Update(&md5, [fileData bytes], [fileData length]);
        if([fileData length] == 0) done = YES;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString* s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1],
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    return s;
}

- (CGFloat)fontSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size minimumFontSize:(CGFloat)minimumFontSize
{
    CGFloat fontSize = [font pointSize];
    CGFloat height = [self boundingSizeWithFont:font width:size.width].height;
    UIFont *newFont = font;
    
    //Reduce font size while too large, break if no height (empty string)
    while (height > size.height && height != 0 && fontSize > minimumFontSize) {
        fontSize--;
        newFont = [UIFont fontWithName:font.fontName size:fontSize];
        height = [self boundingSizeWithFont:newFont width:size.width].height;
    };
    
    // Loop through words in string and resize to fit
    for (NSString *word in [self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]) {
        CGFloat width = [word boundingSizeWithFont:newFont width:CGFLOAT_MAX].width;
        while (width > size.width && width != 0 && fontSize > minimumFontSize) {
            fontSize--;
            newFont = [UIFont fontWithName:font.fontName size:fontSize];
            width = [word boundingSizeWithFont:newFont width:CGFLOAT_MAX].width;
        }
    }
    return fontSize;
}

- (CGSize)boundingSizeWithFont:(UIFont *)font width:(CGFloat)width
{
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:self attributes:@{ NSFontAttributeName: font }];
    return [attributedText boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
}

@end