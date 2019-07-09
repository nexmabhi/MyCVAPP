//  JOCircleView.m
//
//  Created by Abhishek Dsilva on 12/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>

#import "JOCircleView.h"

@implementation JOCircleView

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.layer setCornerRadius:self.frame.size.width / 2.0];
    self.layer.masksToBounds = YES;
}

@end
