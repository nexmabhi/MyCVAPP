//
//  CVTutorialViewController.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 6/08/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//

#import "CVTutorialViewController.h"

#import "CVTutorialSwipeView.h"

static NSString *const CVTutorialPresentKey = @"CVTutorialPresentKey";

@interface CVTutorialViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, weak) IBOutlet CVTutorialSwipeView *swipeView;

@end

@implementation CVTutorialViewController

+ (BOOL)needsToPresentTutorials
{
    NSUserDefaults *defailts = [NSUserDefaults standardUserDefaults];
    if ([defailts valueForKey:CVTutorialPresentKey] == nil ||
        [defailts boolForKey:CVTutorialPresentKey]) {
        [defailts setBool:NO forKey:CVTutorialPresentKey];
        [defailts synchronize];
        return YES;
    }
    
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.swipeView.backgroundColor = [UIColor clearColor];
    
    self.backgroundImageView.image = self.backgroundImage;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setNeedsStatusBarAppearanceUpdate:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self becomeFirstResponder];
    
    [self.swipeView startAnimating];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self resignFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - Rotation

- (BOOL)shouldAutorotate {
    return NO;
}

#pragma mark - Status Bar

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Shake

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
