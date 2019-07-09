//
//  UIApplication+Extension.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 13/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import <MessageUI/MessageUI.h>

#import "UIApplication+Extension.h"

@implementation UIApplication (Extension)

+ (BOOL)emailAvailable {
    return [MFMailComposeViewController canSendMail];
}

+ (BOOL)phoneAvailable {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
}

@end
