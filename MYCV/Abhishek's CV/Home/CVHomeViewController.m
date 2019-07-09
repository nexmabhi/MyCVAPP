//
//  CVHomeViewController.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.

#import "CVHomeViewController.h"

#import "CVTutorialViewController.h"
#import "CVPageViewController.h"

#import "CVProfileView.h"

#import "UIView+Snapshot.h"

/// Storyboard identifier for CVTimelineNavigationController.
static NSString *CVTimelineViewControllerIdentifier = @"CVTimelineNavigationController";
/// Storyboard identifier for CVExtraCurricularNavigationController.
static NSString *CVExtraCurricularViewControllerIdentifier = @"CVExtraCurricularNavigationController";
/// Storyboard identifier for CVEducationViewController.
static NSString *CVEducationViewControllerIdentifier = @"CVEducationViewController";
/// Storyboard identifier for CVReferencesCollectionViewController.
static NSString *CVReferencesViewControllerIdentifier = @"CVReferencesCollectionViewController";
/// Storyboard identifier for CVTimelineSplitViewController.
static NSString *CVTimelineSplitViewControllerIdentifier = @"CVTimelineSplitViewController";
/// Storyboard identifier for CVExtraCurricularSplitViewController.
static NSString *CVExtraCurricularSplitViewControllerIdentifier = @"CVExtraCurricularSplitViewController";

@interface CVHomeViewController () <CVProfileViewDelegate, CVProfileViewDataSource, UIPageViewControllerDelegate>

/// The constraint for the height of the profile view. Changing its constant
/// value changes the height of the pagesView.
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *profileViewHeightLayoutConstraint;

/// The profile view
@property (nonatomic, weak) IBOutlet CVProfileView *profileView;
/// Container view which handles displaying the views for each page.
@property (nonatomic, weak) IBOutlet UIView *pagesView;

/// A visual indicator to show what page is currently displayed.
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;

/// An array to store the storyboard identifiers for the view controllers
/// to be paged.
/// NOTE: they are different for iPad and iPhone.
@property (nonatomic, strong) NSArray *pageContentViewControllerIdentifiers;

/// Property to remember the last description text before the profile view
/// is extended via the profileViewHeightLayoutConstraint.
@property (nonatomic, strong) NSString *descriptionTextBeforeInfoTransition;

@end

@implementation CVHomeViewController

- (void)loadView {
    [super loadView];

    CVProfileView *profileView = self.profileView;
    profileView.delegate = self;
    profileView.dataSource = self;
    profileView.personalInfo = [CVPersonalInfo personalInfo];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self becomeFirstResponder];

    [self.profileView handleBackgroundImageBlur:animated];
    
    if ([CVTutorialViewController needsToPresentTutorials]) {
        [self presentTutorial];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setNeedsStatusBarAppearanceUpdate:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self resignFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.profileView.expanded) {
        return UIStatusBarStyleDefault;
    }

    return UIStatusBarStyleLightContent;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}

#pragma mark - Getters & Setters

- (NSArray *)pageContentViewControllerIdentifiers {
    if (self->_pageContentViewControllerIdentifiers == nil) {
        // Set the identifiers for the decive.
        NSArray *identifiers = nil;
        if (IS_IPAD) {
            identifiers = @[CVTimelineSplitViewControllerIdentifier,
                            CVExtraCurricularSplitViewControllerIdentifier,
                            CVEducationViewControllerIdentifier,
                            CVReferencesViewControllerIdentifier];
        } else {
            identifiers = @[CVTimelineViewControllerIdentifier,
                            CVExtraCurricularViewControllerIdentifier,
                            CVEducationViewControllerIdentifier,
                            CVReferencesViewControllerIdentifier];
        }

        self->_pageContentViewControllerIdentifiers = identifiers;

        // Indicate the number of pages to display in the page control.
        self.pageControl.numberOfPages = [identifiers count];
    }

    return self->_pageContentViewControllerIdentifiers;
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Page Segue"]) {
        // Set the page view controller's properties.
        CVPageViewController *pageViewController = [segue destinationViewController];
        pageViewController.delegate = self;
        pageViewController.viewControllerIdentifiers = self.pageContentViewControllerIdentifiers;
        // Refresh the UI.
        [self refreshFromPageViewController:pageViewController];
    }
    if ([segue.identifier isEqualToString:@"Tutorial Segue"]) {
        CVTutorialViewController *tutorialViewController = (CVTutorialViewController *)segue.destinationViewController;

        UIImage *viewSnapshot = [self.view imageWithDarkEffect];
        tutorialViewController.backgroundImage = viewSnapshot;
    }
}

#pragma mark - Logic

/**
 *  Refreshes the description label in the profile view and the page
 *  control indicator.
 *
 *  @param pageViewController The page view controller who's page has changed.
 */
- (void)refreshFromPageViewController:(UIPageViewController *)pageViewController {
    // In our case we only ever load one page thus this array will only
    // ever contain one element.
    UIViewController *currentController = [pageViewController.viewControllers lastObject];
    NSString *controllerIdentifier = NSStringFromClass([currentController class]);

    if ([controllerIdentifier isEqualToString:CVReferencesViewControllerIdentifier]) {
        pageViewController.view.backgroundColor = [UIColor backgroundGrayColor];
    } else {
        pageViewController.view.backgroundColor = [UIColor whiteColor];
    }

    self.profileView.descriptionLabel.text = currentController.title;

    // Because we store the storyboard identifiers as the class names
    // we can extract the index from the identifiers array.
    self.pageControl.currentPage = [self.pageContentViewControllerIdentifiers indexOfObject:controllerIdentifier];
}

/**
 *  Layout the profile's and pages view's subviews.
 *
 *  @param animated        Flag to set wether to animate the changes.
 *  @param completionBlock Called when the layout has completed.
 */
- (void)layoutSubviews:(BOOL)animated
            completion:(void (^)(BOOL finished))completionBlock {
    if (animated) {
        [UIView animateWithDuration:0.6
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
            [self.profileView layoutIfNeeded];
            [self.pagesView layoutIfNeeded];
        } completion:completionBlock];
    } else {
        [self.profileView layoutIfNeeded];
        [self.pagesView layoutIfNeeded];

        if (completionBlock) {
            completionBlock(YES);
        }
    }
}

#pragma mark - Tutorial

- (void)presentTutorial
{
    [self performSegueWithIdentifier:@"Tutorial Segue" sender:self];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        if (self.presentedViewController == nil) {
             [self presentTutorial];   
        }
    }
}

#pragma mark - Profile View

- (void)profileViewDidSelectInfoButton:(CVProfileView *)profileView {
    // Set the profile view height to the full height of the view.
    self.profileViewHeightLayoutConstraint.constant = self.view.frame.size.height;

    // Save the current description label text.
    self.descriptionTextBeforeInfoTransition = self.profileView.descriptionLabel.text;
    // Update the description label text.
    self.profileView.descriptionLabel.text = self.profileView.personalInfo.location;

    self.profileView.backgroundImageView.image = self.profileView.personalInfo.backgroundImage;

    // Set the UI changes.
    BOOL animated = YES;
    [self.pageControl setHidden:YES animated:animated];
    [self setNeedsStatusBarAppearanceUpdate:animated];
    [self layoutSubviews:animated completion:nil];
    [self.profileView handleBackgroundImageBlur:NO];
}

- (void)profileViewDidSelectCloseButton:(CVProfileView *)profileView {
    // Set the profile view's height back to it layout length.
    self.profileViewHeightLayoutConstraint.constant = self.profileView.length;

    // Set the UI changes.
    BOOL animated = YES;
    [self.pageControl setHidden:NO animated:animated];
    [self setNeedsStatusBarAppearanceUpdate:animated];
    [self layoutSubviews:animated completion:^(BOOL finished) {
        [self.profileView handleBackgroundImageBlur:animated];
        // Reset the description label text back to what it was.
        self.profileView.descriptionLabel.text = self.descriptionTextBeforeInfoTransition;
        // Remove the stored text.
        self.descriptionTextBeforeInfoTransition = nil;
    }];
}

- (UIViewController *)controllerForEmailPresentationInProfileView:(CVProfileView *)profileView {
    return self;
}

#pragma mark - Page Control

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    [[NSNotificationCenter defaultCenter] postNotificationName:CVPagingNotification object:self userInfo:@{ CVPagingStateKey: @(CVPagingStateBeganScroll), CVPagingControllersKey: pendingViewControllers }];
}

- (void) pageViewController:(UIPageViewController *)pageViewController
         didFinishAnimating:(BOOL)finished
    previousViewControllers:(NSArray *)previousViewControllers
        transitionCompleted:(BOOL)completed {
    // Only refresh the UI if the transition was completed.
    if (completed) {
        [self refreshFromPageViewController:pageViewController];
    }

    if (finished) {
        [[NSNotificationCenter defaultCenter] postNotificationName:CVPagingNotification object:self userInfo:@{ CVPagingStateKey: @(CVPagingStateFinishedScroll), CVPagingControllersKey: previousViewControllers }];
    }
}

@end
