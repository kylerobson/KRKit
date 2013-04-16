//
//  NSData+KRAdditions.m
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import "NSData+KRAdditions.h"
#import <CommonCrypto/CommonDigest.h>

static const char _base64EncodingTable[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation NSData (KRAdditions)

- (NSString *)hexadecimalString
{
    NSUInteger dataLength = self.length;
    uint8_t *devTokenBytes = (uint8_t *)[self bytes];
    NSMutableString *hexVal = [NSMutableString stringWithCapacity: (3 * dataLength)]; //3 = 2-chars for hexcode of byteval + 1 char for space separator
    while (dataLength > 0) {
        [hexVal appendFormat: @"%02x ", *devTokenBytes];
        devTokenBytes++;
        dataLength--;
    }
    
    return [NSString stringWithString:hexVal];
}

- (NSString *)PNGDataURLRepresentation
{
    return [@"data:image/png;base64," stringByAppendingString:self.base64EncodedString];
}

- (NSString *)GIFDataURLRepresentation
{
    return [@"data:image/gif;base64," stringByAppendingString:self.base64EncodedString];
}

- (NSString *)CSSDataURLRepresentation
{
    return [@"data:text/css;base64," stringByAppendingString:self.base64EncodedString];
}

- (NSString *)JPGDataURLRepresentation
{
    return [@"data:image/jpg;base64," stringByAppendingString:self.base64EncodedString];
}

- (NSString *)base64EncodedString
{
    const unsigned char * objRawData = [self bytes];
    char * objPointer;
    char * strResult;
    
    // Get the Raw Data length and ensure we actually have data
    int intLength = [self length];
    if (intLength == 0) return nil;
    
    // Setup the String-based Result placeholder and pointer within that placeholder
    strResult = (char *)calloc(((intLength + 2) / 3) * 4, sizeof(char));
    objPointer = strResult;
    
    // Iterate through everything -- keep going until we have less than 24 bits
    while (intLength > 2)
    {
        *objPointer++ = _base64EncodingTable[objRawData[0] >> 2];
        *objPointer++ = _base64EncodingTable[((objRawData[0] & 0x03) << 4) + (objRawData[1] >> 4)];
        *objPointer++ = _base64EncodingTable[((objRawData[1] & 0x0f) << 2) + (objRawData[2] >> 6)];
        *objPointer++ = _base64EncodingTable[objRawData[2] & 0x3f];
        
        // we just handled 3 octets (24 bits) of data
        objRawData += 3;
        intLength -= 3;
    }
    
    // now deal with the tail end of things
    if (intLength != 0)
    {
        *objPointer++ = _base64EncodingTable[objRawData[0] >> 2];
        if (intLength > 1)
        {
            *objPointer++ = _base64EncodingTable[((objRawData[0] & 0x03) << 4) + (objRawData[1] >> 4)];
            *objPointer++ = _base64EncodingTable[(objRawData[1] & 0x0f) << 2];
            *objPointer++ = '=';
        } else
        {
            *objPointer++ = _base64EncodingTable[(objRawData[0] & 0x03) << 4];
            *objPointer++ = '=';
            *objPointer++ = '=';
        }
    }
    
    // Terminate the string-based result
    *objPointer = '\0';
    
    // Return the results as an NSString object
    NSString *result = [NSString stringWithCString:strResult encoding:NSASCIIStringEncoding];
    free(strResult);
    return result;
}

- (NSString *)md5
{
    unsigned char result[16];
    CC_MD5( self.bytes, self.length, result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];  
}

@end