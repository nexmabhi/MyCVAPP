//  CVAboutMeView.m
//
//  Created by Abhishek Dsilva on 12/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVAboutMeView.h"

#import "CVPersonalInfo.h"

#import "CVContactor.h"

@interface CVAboutMeView ()

@property (nonatomic, weak) IBOutlet UIButton *emailButton;
@property (nonatomic, weak) IBOutlet UIButton *phoneButton;

@property (nonatomic, weak) IBOutlet UIImageView *fadeImageView;

@property (nonatomic, weak) IBOutlet UITextView *textView;

@end

@implementation CVAboutMeView

- (void)didMoveToWindow {
    [super didMoveToWindow];

    self.emailButton.enabled = [UIApplication emailAvailable];
    self.phoneButton.enabled = [UIApplication phoneAvailable];

    if (IS_IPAD) {
        UIImage *ipadFadeImage = [UIImage imageNamed:@"ipad_fade"];
        UIImage *strechedImage = [ipadFadeImage resizableImageWithCapInsets:UIEdgeInsetsMake(80.0f, 80.0f, 80.0f, 80.0f) resizingMode:UIImageResizingModeStretch];
        self.fadeImageView.image = strechedImage;
    }
}

#pragma mark - Setters & Getters

- (void)setPersonalInfo:(CVPersonalInfo *)personalInfo {
    if (self->_personalInfo != personalInfo) {
        self->_personalInfo = personalInfo;

        [self.emailButton setTitle:personalInfo.email forState:UIControlStateNormal];
        [self.phoneButton setTitle:personalInfo.phoneNumber forState:UIControlStateNormal];
        self.textView.text = personalInfo.detailDescription;
    }
}

#pragma mark - Actions

- (IBAction)callAction:(id)sender {
    [CVContactor callNumber:self.personalInfo.phoneNumber];
}

- (IBAction)emailAction:(id)sender {
    if (self.emailPresentController) {
        [[CVContactor sharedContactor] emailReciepients:@[self.personalInfo.email] inController:self.emailPresentController];
    }
}

@end
