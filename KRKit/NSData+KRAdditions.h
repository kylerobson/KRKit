//
//  NSData+KRAdditions.h
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (KRAdditions)

- (NSString *)hexadecimalString;
- (NSString *)PNGDataURLRepresentation;
- (NSString *)CSSDataURLRepresentation;
- (NSString *)GIFDataURLRepresentation;
- (NSString *)JPGDataURLRepresentation;
- (NSString *)md5;

@end