//  CVContactor.m
//
//  Created by Abhishek Dsilva on 15/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import <MessageUI/MessageUI.h>

#import "CVContactor.h"

@interface CVContactor () <MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) UIViewController *controller;

@end

@implementation CVContactor

+ (instancetype)sharedContactor {
    static __DISPATCH_ONCE__ id singletonObject = nil;

    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        singletonObject = [[self alloc] init];
    });

    return singletonObject;
}

+ (void)callNumber:(NSString *)number {
    if ([UIApplication phoneAvailable]) {
        NSString *telPhone = [[[NSString alloc] initWithFormat:@"tel://%@", number] stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSURL *phoneURL = [NSURL URLWithString:telPhone];
        if ([[UIApplication sharedApplication] canOpenURL:phoneURL]) {
            [[UIApplication sharedApplication] openURL:phoneURL];
        }
    }
}

- (void)emailReciepients:(NSArray *)reciepients
            inController:(UIViewController *)controller {
    if ([UIApplication emailAvailable]) {
        MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
        composer.mailComposeDelegate = self;
        [composer setToRecipients:reciepients];
        [controller presentViewController:composer animated:YES completion:nil];

        self.controller = controller;
    }
}

#pragma mark - Mail Delegate

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {
    if (error) {
        [error handle];
    }

    [self.controller dismissViewControllerAnimated:YES completion:^{
        self.controller = nil;
    }];
}

@end
