//  CVRoundedRectImageView.m
//
//  Created by Abhishek Dsilva on 13/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>

#import "CVRoundedRectImageView.h"

@implementation CVRoundedRectImageView

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.layer setCornerRadius:18.0f];
    self.layer.masksToBounds = YES;
}

@end
