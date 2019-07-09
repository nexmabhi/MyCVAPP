//
//  CVEducationViewController.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVEducationViewController.h"

@interface CVEducationViewController ()

@property (nonatomic, weak) IBOutlet UITextView *textView;
@property (nonatomic, weak) IBOutlet UILabel *establishmentLabel;
@property (nonatomic, weak) IBOutlet UILabel *statusLabel;
@property (nonatomic, weak) IBOutlet UILabel *completionDateLabel;
@property (nonatomic, weak) IBOutlet UIImageView *fadeImageView;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *textViewHeightLayoutConstraint;

@end

@implementation CVEducationViewController

@synthesize pageIndex = _pageIndex;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"EducationTitle", nil);

    if (IS_IPAD) {
        UIImage *ipadFadeImage = [UIImage imageNamed:@"ipad_fade"];
        UIImage *strechedImage = [ipadFadeImage resizableImageWithCapInsets:UIEdgeInsetsMake(80.0f, 80.0f, 80.0f, 80.0f) resizingMode:UIImageResizingModeStretch];
        self.fadeImageView.image = strechedImage;
    }

    [self populateSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self layoutTextView];
}

#pragma mark - Layout

- (void)layoutTextView {
    UITextView *textView = self.textView;
    CGRect idealTextViewFrame = textView.frame;
    CGSize maxSize = CGSizeMake(idealTextViewFrame.size.width, CGFLOAT_MAX);

    idealTextViewFrame.size = [textView sizeThatFits:maxSize];

    UIView *fadeSuperview = self.fadeImageView.superview;
    CGFloat maxHeight = ABS(fadeSuperview.frame.size.height - textView.frame.origin.y) - floorf(self.fadeImageView.frame.size.height / 2.0);
    if (idealTextViewFrame.size.height > maxHeight) {
        self.textView.scrollEnabled = YES;
        self.textViewHeightLayoutConstraint.constant = maxHeight;
    } else {
        self.textView.scrollEnabled = NO;
        self.textViewHeightLayoutConstraint.constant = idealTextViewFrame.size.height;
    }
}

#pragma mark - Logic

- (void)populateSubviews {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Education" ofType:@"plist"];
    NSDictionary *educationInfo = [[NSDictionary alloc] initWithContentsOfFile:filePath];

    self.completionDateLabel.text = educationInfo[@"completion"];
    self.establishmentLabel.text = educationInfo[@"establishment"];
    self.statusLabel.text = educationInfo[@"status"];
    self.textView.text = educationInfo[@"description"];
}

@end
