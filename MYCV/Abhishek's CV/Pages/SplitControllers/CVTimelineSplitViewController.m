//
//  CVTimelineSplitViewController.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 11/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVTimelineSplitViewController.h"

#import "CVTimelineTableViewController.h"

@interface CVTimelineSplitViewController () <CVTimelineTableViewControllerDelegate>

@end

@implementation CVTimelineSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Experience";
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];

    if ([segue.identifier isEqualToString:@"Timeline Segue"]) {
        CVTimelineTableViewController *timelineViewController = segue.destinationViewController;
        timelineViewController.delegate = self;
    }
}

#pragma mark - Logic

- (NSString *)detailSegueIdentifier {
    return CVDetailSegueIdentifier;
}

#pragma mark - Timeline Delegate

- (void)timelineViewController:(UIViewController *)controller
           didSelectExperience:(CVExperienceObject *)experience {
    [self updateDetailControllerWithExperienceObject:experience];
}

@end
