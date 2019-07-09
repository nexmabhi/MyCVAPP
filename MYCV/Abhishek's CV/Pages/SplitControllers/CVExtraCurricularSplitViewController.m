//
//  CVExtraCurricularSplitViewController.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 11/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVExtraCurricularSplitViewController.h"

#import "CVExtraCurricularTableViewController.h"

@interface CVExtraCurricularSplitViewController () <CVExtraCurricularTableViewControllerDelegate>

@end

@implementation CVExtraCurricularSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Extra Curricular";
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];

    if ([segue.identifier isEqualToString:@"Extra Curricular Segue"]) {
        CVExtraCurricularTableViewController *extraCurricularViewController = segue.destinationViewController;
        extraCurricularViewController.delegate = self;
    }
}

#pragma mark - Logic

- (NSString *)detailSegueIdentifier {
    return CVDetailSegueIdentifier;
}

#pragma mark - Timeline Delegate

- (void)extraCurricularViewController:(CVExtraCurricularTableViewController *)controller
                  didSelectExperience:(CVExperienceObject *)experience {
    [self updateDetailControllerWithExperienceObject:experience];
}

@end
