//
//  UIImage+KRAdditions.h
//  KRKit
//
//  Created by Kyle Robson on 1/25/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (KRAdditions)

+ (UIImage *)imageWithContentsOfBundleFileNamed:(NSString *)name;
+ (UIImage *)imageWithContentsOfCachesFileNamed:(NSString *)name;
+ (UIImage *)imageWithContentsOfDocumentsFileNamed:(NSString *)name;
+ (UIImage *)drawImage:(UIImage*)fgImage inImage:(UIImage*)bgImage inPoint:(CGPoint)point;

@end