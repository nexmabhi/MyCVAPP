//
//  UIViewController+Extension.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 12/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

- (void)setNeedsStatusBarAppearanceUpdate:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    } else {
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

@end
