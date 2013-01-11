//
//  NSFileManager+Additions.m
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import "NSFileManager+Additions.h"

@implementation NSFileManager (Additions)

- (NSString *)fullPathForRelativePath:(NSString *)relativePath persistedLongTerm:(BOOL)isPersistedLongTerm
{
    NSString *fullPath;
    if (isPersistedLongTerm) {
        fullPath = [relativePath stringByAppendingPathComponentToDocumentsDirectory];
    }
    else {
        fullPath = [relativePath stringByAppendingPathComponentToCachesDirectory];
    }
    return fullPath;
}

@end