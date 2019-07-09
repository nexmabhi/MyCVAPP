//  CVDetailViewController.m
//
//  Created by Abhishek Dsilva on 12/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVDetailViewController.h"

#import "CVPageContentNavigationController.h"

#import "CVRoundedRectImageView.h"

@interface CVDetailViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet CVRoundedRectImageView *organisationImageView;

@property (nonatomic, weak) IBOutlet UILabel *positionLabel;
@property (nonatomic, weak) IBOutlet UILabel *organisationLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

@property (nonatomic, weak) IBOutlet UITextView *detailTextView;

@end

@implementation CVDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.interactivePopGestureRecognizer.delegate = self;

    [self refreshSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if ([self.navigationController respondsToSelector:@selector(allowsPaging)]) {
        ((CVPageContentNavigationController *)self.navigationController).allowsPaging = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    if ([self.navigationController respondsToSelector:@selector(allowsPaging)]) {
        ((CVPageContentNavigationController *)self.navigationController).allowsPaging = YES;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [self.navigationController popToRootViewControllerAnimated:animated];
}

#pragma mark - Setters & Getters

- (void)setExperience:(CVExperienceObject *)experience {
    if (self->_experience != experience) {
        self->_experience = experience;

        if (IS_IPAD) {
            [self refreshSubviews];
        }
    }
}

#pragma mark - Logic

- (void)refreshSubviews {
    CVExperienceObject *experience = self.experience;

    self.organisationImageView.image = experience.organisationImage;
    self.positionLabel.text = experience.position;
    self.organisationLabel.text = experience.organisation;
    self.detailTextView.text = experience.detailedDescription;

    self.dateLabel.text = [experience.startDate combinedCondensedStringWithEndDate:experience.endDate withMidString:@" - "];
}

#pragma mark - Actions

- (IBAction)backAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
