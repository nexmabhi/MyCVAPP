//
//  UIColor+Extension.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 13/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (UIColor *)colorFromString:(NSString *)string {
    NSArray *components = [string componentsSeparatedByString:@","];
    NSUInteger componentsCount = [components count];

    if (componentsCount != 4) {
        return nil;
    }

    CGFloat red = [components[0] floatValue];
    CGFloat green = [components[1] floatValue];
    CGFloat blue = [components[2] floatValue];
    CGFloat alpha = [components[3] floatValue];

    return [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:alpha];
}

+ (UIColor *)defaultBlueColor {
    return [UIColor colorFromString:@"0,122,255,1"];
}

+ (UIColor *)backgroundGrayColor {
    return [UIColor colorFromString:@"245,245,245,1"];
}

@end
