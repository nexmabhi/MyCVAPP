//  CVPageContentSplitViewController.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 12/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVPageContentSplitViewController.h"

#import "CVDetailViewController.h"

@interface CVPageContentSplitViewController ()

@property (nonatomic, strong) CVDetailViewController *detailViewController;

@end

@implementation CVPageContentSplitViewController

@synthesize pageIndex = _pageIndex;

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:[self detailSegueIdentifier]]) {
        self.detailViewController = segue.destinationViewController;
    }
}

#pragma mark - Logic

- (NSString *)detailSegueIdentifier {
    return nil;
}

- (void)updateDetailControllerWithExperienceObject:(CVExperienceObject *)experienceObject {
    self.detailViewController.experience = experienceObject;
}

@end
