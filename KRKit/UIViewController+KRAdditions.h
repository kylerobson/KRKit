//
//  UIViewController+KRAdditions.h
//  KRKit
//
//  Created by Kyle Robson on 3/1/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (KRAdditions)

- (void)containerAddChildViewController:(UIViewController *)childViewController parentView:(UIView *)view;
- (void)containerAddChildViewController:(UIViewController *)childViewController;
- (void)containerRemoveChildViewController:(UIViewController *)childViewController;
- (void)presentViewControllerPopup:(UIViewController *)viewController completion:(void (^)())completion;
- (void)dismissViewControllerPopup:(UIViewController *)viewController completion:(void (^)())completion;

@end