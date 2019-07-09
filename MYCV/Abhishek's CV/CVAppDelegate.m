//
//  CVAppDelegate.m
//   Abhishek's CV
//
//  Created by A on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVAppDelegate.h"

@implementation CVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    
    return YES;
}

@end
