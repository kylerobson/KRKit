//
//  UIDevice+Additions.m
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import "UIDevice+Additions.h"
#import <sys/utsname.h>

@implementation UIDevice (Additions)

@dynamic isIphone5Sized;
@dynamic model;

- (BOOL)isIphone5Sized
{
    return CGSizeEqualToSize([[UIScreen mainScreen] preferredMode].size,CGSizeMake(640.0f, 1136.0f));
}

- (NSString *)model
{
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

@end