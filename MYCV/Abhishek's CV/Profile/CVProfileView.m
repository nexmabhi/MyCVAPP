//
//  CVProfileView.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVProfileView.h"

#import "CVAboutMeView.h"

#import "UIView+Snapshot.h"

static CGFloat CVPhotoScaleFactor = 2.0f;

@interface CVProfileView ()

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *photoWidthLayoutConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *photoHeightLayoutConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *photoHorizontalLayoutConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *photoVerticalLayoutConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *nameVerticalLayoutConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *nameHorizontalLayoutConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *descriptionHorizontalLayoutConstraint;

@property (nonatomic, strong) NSMapTable *initialConstraintConstants;

@property (nonatomic, weak) IBOutlet UIImageView *profilePicImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIButton *infoButton;

@property (nonatomic, weak) CVAboutMeView *aboutMeView;
@property (nonatomic, weak) UIImageView *blurredImageView;

@property (nonatomic, weak) UITextView *textView;

@property (nonatomic) CGSize expandedPhotoSize;
@property (nonatomic) BOOL expanded;

@end

@implementation CVProfileView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pagingAction:)
                                                 name:CVPagingNotification
                                               object:nil];

    UIImageView *blurredImageView = [[UIImageView alloc] initWithFrame:self.frame];
    [blurredImageView setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self insertSubview:blurredImageView aboveSubview:self.backgroundImageView];

    NSDictionary *bindings = NSDictionaryOfVariableBindings(blurredImageView);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[blurredImageView]|" options:0 metrics:nil views:bindings]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[blurredImageView]|" options:0 metrics:nil views:bindings]];

    self.blurredImageView = blurredImageView;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Getters & Setters

- (void)setPersonalInfo:(CVPersonalInfo *)personalInfo {
    if (self->_personalInfo != personalInfo) {
        self->_personalInfo = personalInfo;

        self.backgroundImageView.image = personalInfo.backgroundImage;
        self.nameLabel.text = personalInfo.fullName;
        self.profilePicImageView.image = personalInfo.profileImage;
    }
}

- (void)setExpanded:(BOOL)expanded {
    if (self->_expanded != expanded) {
        self->_expanded = expanded;

        UIColor *tintColor = (expanded) ? [UIColor blackColor] : [UIColor whiteColor];
        self.nameLabel.textColor = tintColor;
        self.descriptionLabel.textColor = tintColor;
        self.tintColor = tintColor;

        [self layoutMainInformation];
        [self handleAboutMeView];
    }
}

- (void)setTintColor:(UIColor *)tintColor {
    [super setTintColor:tintColor];

    self.infoButton.tintColor = tintColor;
}

- (CGSize)expandedPhotoSize {
    if (CGSizeEqualToSize(self->_expandedPhotoSize, CGSizeZero)) {
        self->_expandedPhotoSize = CGSizeMake(self.photoWidthLayoutConstraint.constant * CVPhotoScaleFactor, self.photoHeightLayoutConstraint.constant * CVPhotoScaleFactor);
    }
    return self->_expandedPhotoSize;
}

- (NSMapTable *)initialConstraintConstants {
    if (self->_initialConstraintConstants == nil) {
        NSMapTable *initialTable = [NSMapTable mapTableWithKeyOptions:NSMapTableWeakMemory
                                                         valueOptions:NSMapTableStrongMemory];
        [initialTable setObject:@(self.photoWidthLayoutConstraint.constant)
                         forKey:self.photoWidthLayoutConstraint];
        [initialTable setObject:@(self.photoHeightLayoutConstraint.constant)
                         forKey:self.photoHeightLayoutConstraint];
        [initialTable setObject:@(self.photoHorizontalLayoutConstraint.constant)
                         forKey:self.photoHorizontalLayoutConstraint];
        [initialTable setObject:@(self.photoVerticalLayoutConstraint.constant)
                         forKey:self.photoVerticalLayoutConstraint];
        [initialTable setObject:@(self.nameVerticalLayoutConstraint.constant)
                         forKey:self.nameVerticalLayoutConstraint];
        [initialTable setObject:@(self.nameHorizontalLayoutConstraint.constant)
                         forKey:self.nameHorizontalLayoutConstraint];
        [initialTable setObject:@(self.descriptionHorizontalLayoutConstraint.constant)
                         forKey:self.descriptionHorizontalLayoutConstraint];

        self->_initialConstraintConstants = initialTable;
    }

    return self->_initialConstraintConstants;
}

#pragma mark - Layout

- (CGFloat)length {
    return 108.0f;
}

- (void)layoutSubviews {
    [self layoutMainInformation];

    [super layoutSubviews];

    if (self.aboutMeView) {
        [self layoutAboutMe];
    }
}

- (void)layoutMainInformation {
    if (self.expanded) {
        NSMapTable *finalConstraintConstants = [self recalculatedFinalConstraintConstants];
        for (NSLayoutConstraint *constraint in finalConstraintConstants) {
            CGFloat constant = [[finalConstraintConstants objectForKey:constraint] floatValue];

            constraint.constant = constant;
        }
    } else {
        NSMapTable *initialConstraintConstants = self.initialConstraintConstants;
        for (NSLayoutConstraint *constraint in initialConstraintConstants) {
            CGFloat constant = [[initialConstraintConstants objectForKey:constraint] floatValue];

            constraint.constant = constant;
        }
    }
}

- (void)layoutAboutMe {
    // Because I have lost all faith in Autolayout.
    CVAboutMeView *aboutMeView = self.aboutMeView;
    CGRect bounds = self.bounds;
    CGRect aboutMeViewFrame = aboutMeView.frame;

    if (IS_IPHONE) {
        
        
        aboutMeViewFrame.size = CGSizeMake([[UIScreen mainScreen] bounds].size.width, floorf([[UIScreen mainScreen] bounds].size.height * 0.85));
        aboutMeViewFrame.origin.y = bounds.size.height - aboutMeViewFrame.size.height;
    } else {
        aboutMeViewFrame.size = CGSizeMake(480.0f, 480.0f);
        aboutMeViewFrame.origin.y = floorf(bounds.size.height * 0.3);
        aboutMeViewFrame.origin.x = floorf(bounds.size.width / 2.0 - aboutMeViewFrame.size.width / 2.0);
    }
    aboutMeView.frame = aboutMeViewFrame;
}

#pragma mark - Logic

- (void)handleAboutMeView {
    if (self.expanded) {
        CVAboutMeView *aboutMeView = nil;
        for (id view in [[NSBundle mainBundle] loadNibNamed:@"AboutMe" owner:nil options:nil]) {
            if ([view isKindOfClass:[CVAboutMeView class]]) {
                aboutMeView = view;
                break;
            }
        }

        [aboutMeView setHidden:YES animated:NO];
        aboutMeView.tintColor = [UIColor defaultBlueColor];
        aboutMeView.personalInfo = self.personalInfo;
        if ([self.dataSource respondsToSelector:@selector(controllerForEmailPresentationInProfileView:)]) {
            aboutMeView.emailPresentController = [self.dataSource controllerForEmailPresentationInProfileView:self];
        }

        [self insertSubview:aboutMeView aboveSubview:self.backgroundImageView];
        [aboutMeView setHidden:NO animated:YES];

        self.aboutMeView = aboutMeView;
    } else {
        CVAboutMeView *aboutMeView = self.aboutMeView;
        [aboutMeView setHidden:YES
                      animated:NO
                      duration:0.3
                    completion:^(BOOL finished) {
            if (finished) {
                [self.aboutMeView removeFromSuperview];
                self.aboutMeView = nil;
            }
        }];
    }
}

- (NSMapTable *)recalculatedFinalConstraintConstants {
    CGRect frame = self.frame;

    CGFloat photoHeightConstant = 0.0f;
    CGFloat photoWidthConstant = 0.0f;
    CGFloat photoHorizontalConstant = 0.0f;
    CGFloat photoVerticalConstant = 0.0f;
    CGFloat nameVerticalConstant = 0.0f;
    CGFloat nameHorizontalConstant = 0.0f;
    CGFloat descriptionHorizontalConstant = 0.0f;

    NSMapTable *finalTable = [NSMapTable mapTableWithKeyOptions:NSMapTableWeakMemory
                                                   valueOptions:NSMapTableStrongMemory];

    photoHeightConstant = self.expandedPhotoSize.height;
    [finalTable setObject:@(photoHeightConstant)
                   forKey:self.photoWidthLayoutConstraint];

    photoWidthConstant = self.expandedPhotoSize.width;
    [finalTable setObject:@(photoWidthConstant)
                   forKey:self.photoHeightLayoutConstraint];

    photoHorizontalConstant = floorf(frame.size.width / 2.0 - photoWidthConstant / 2.0);
    [finalTable setObject:@(photoHorizontalConstant)
                   forKey:self.photoHorizontalLayoutConstraint];

    photoVerticalConstant = floorf(frame.size.height / 10.0f);
    [finalTable setObject:@(photoVerticalConstant)
                   forKey:self.photoVerticalLayoutConstraint];

    nameVerticalConstant = photoVerticalConstant + photoWidthConstant + 15.0f;
    [finalTable setObject:@(nameVerticalConstant)
                   forKey:self.nameVerticalLayoutConstraint];

    nameHorizontalConstant = floorf(frame.size.width / 2.0 - self.nameLabel.frame.size.width / 2.0);
    [finalTable setObject:@(nameHorizontalConstant)
                   forKey:self.nameHorizontalLayoutConstraint];

    [self.descriptionLabel sizeToFit];
    descriptionHorizontalConstant = floorf(frame.size.width / 2.0 - self.descriptionLabel.frame.size.width / 2.0);
    [finalTable setObject:@(descriptionHorizontalConstant)
                   forKey:self.descriptionHorizontalLayoutConstraint];

    return finalTable;
}

- (void)handleBackgroundImageBlur:(BOOL)animated {
    UIImageView *blurredImageView = self.blurredImageView;

    if (blurredImageView.image == nil) {
        blurredImageView.image = [self.backgroundImageView imageWithBlurRadius:10.0f];
    }

    [blurredImageView setHidden:self.expanded
                       animated:animated
                       duration:0.3
                     completion:nil];
}

#pragma mark - Actions

- (void)pagingAction:(NSNotification *)pagingNotification {
    CVPagingState pagingState = [[pagingNotification userInfo][CVPagingStateKey] integerValue];

    self.infoButton.userInteractionEnabled = (pagingState != CVPagingStateBeganScroll);
}

/**
 *  Action triggered when the info button has been touched.
 *
 *  @param sender The info button.
 */
- (IBAction)infoAction:(UIButton *)infoButton {
    // Save the old value to a scop variable.
    BOOL expanded = self.expanded;

    // Update the expand flag.
    self.expanded = !expanded;

    // Call the appropirate delegate method based on the old value.
    if (expanded) {
        if ([self.delegate respondsToSelector:@selector(profileViewDidSelectCloseButton:)]) {
            [self.delegate profileViewDidSelectCloseButton:self];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(profileViewDidSelectInfoButton:)]) {
            [self.delegate profileViewDidSelectInfoButton:self];
        }
    }
}

@end
