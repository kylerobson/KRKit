//
//  UIImage+KRAdditions.m
//  KRKit
//
//  Created by Kyle Robson on 1/25/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import "UIImage+KRAdditions.h"

@implementation UIImage (KRAdditions)

- (UIImage *)imageWithContentsOfBundleFileNamed:(NSString *)name
{
    return [UIImage imageWithContentsOfFile:[name stringByAppendingPathComponentToBundleDirectory]];
}

- (UIImage *)imageWithContentsOfCachesFileNamed:(NSString *)name
{
    return [UIImage imageWithContentsOfFile:[name stringByAppendingPathComponentToCachesDirectory]];
}

- (UIImage *)imageWithContentsOfDocumentsFileNamed:(NSString *)name
{
    return [UIImage imageWithContentsOfFile:[name stringByAppendingPathComponentToDocumentsDirectory]];
}

@end