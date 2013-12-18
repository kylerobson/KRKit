//
//  UIImage+KRAdditions.m
//  KRKit
//
//  Created by Kyle Robson on 1/25/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import "UIImage+KRAdditions.h"
#import "KRKit.h"

@implementation UIImage (KRAdditions)

+ (UIImage *)imageWithContentsOfBundleFileNamed:(NSString *)name
{
    return [UIImage imageWithContentsOfFile:[name stringByAppendingPathComponentToBundleDirectory]];
}

+ (UIImage *)imageWithContentsOfCachesFileNamed:(NSString *)name
{
    return [UIImage imageWithContentsOfFile:[name stringByAppendingPathComponentToCachesDirectory]];
}

+ (UIImage *)imageWithContentsOfDocumentsFileNamed:(NSString *)name
{
    return [UIImage imageWithContentsOfFile:[name stringByAppendingPathComponentToDocumentsDirectory]];
}

+ (UIImage *)drawImage:(UIImage*)fgImage inImage:(UIImage*)bgImage inPoint:(CGPoint)point
{
    UIGraphicsBeginImageContextWithOptions(bgImage.size, FALSE, 0.0f);
    [bgImage drawInRect:CGRectMake(0.0f, 0.0f, bgImage.size.width, bgImage.size.height)];
    [fgImage drawInRect:CGRectMake(point.x, point.y, fgImage.size.width, fgImage.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end