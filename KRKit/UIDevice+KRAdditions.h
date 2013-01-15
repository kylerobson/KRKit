//
//  UIDevice+KRAdditions.h
//  KRKit
//
//  Created by Kyle Robson on 1/11/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (KRAdditions)

@property (nonatomic, assign) BOOL isIphone5Sized;
@property (nonatomic, strong) NSString *model;

@end