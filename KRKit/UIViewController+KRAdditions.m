//
//  UIViewController+KRAdditions.m
//  KRKit
//
//  Created by Kyle Robson on 3/1/13.
//  Copyright (c) 2013 Robson Software Consulting. All rights reserved.
//

#import "UIViewController+KRAdditions.h"

@implementation UIViewController (KRAdditions)

- (void)presentViewControllerPopup:(UIViewController *)viewController completion:(void (^)())completion
{
    viewController.view.frame = CGRectWithSize(self.view.bounds.size);
    viewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [viewController willMoveToParentViewController:self];
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
    
    [UIView animateWithDuration:0.3 / 1.5 animations:^{
        viewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 / 2 animations:^{
            viewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished2) {
            [UIView animateWithDuration:0.3 / 2 animations:^{
                viewController.view.transform = CGAffineTransformIdentity;
                if (completion != nil) {
                    completion();
                }
            }];
        }];
    }];
}

- (void)removeViewControllerPopup:(UIViewController *)viewController
{
    [viewController willMoveToParentViewController:nil];
    [UIView animateWithDuration:.25 animations:^{
        viewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    } completion:^(BOOL finished) {
        if (finished) {
            [viewController.view removeFromSuperview];
            viewController.view.transform = CGAffineTransformIdentity;
            [viewController removeFromParentViewController];
        }
    }];
}

@end