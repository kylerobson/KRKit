//
//  NSData+Additions.h
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Additions)

- (NSString *)hexadecimalString;
- (NSString *)PNGDataURLRepresentation;
- (NSString *)CSSDataURLRepresentation;
- (NSString *)GIFDataURLRepresentation;

@end