//
//  CVPageViewController.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVPageViewController.h"

#import "CVPageContentNavigationController.h"

#import "CVPageContentViewController.h"

@interface CVPageViewController () <UIPageViewControllerDataSource>

@end

@implementation CVPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor backgroundGrayColor];
    self.dataSource = self;
}

- (void)setViewControllerIdentifiers:(NSArray *)viewControllerIdentifiers {
    if (self->_viewControllerIdentifiers != viewControllerIdentifiers) {
        self->_viewControllerIdentifiers = viewControllerIdentifiers;

        if ([viewControllerIdentifiers count] > 0) {
            // Create the initial view contorller from the given controller identifiers.
            UIViewController<CVPageContentViewController> *startingViewController = [self viewControllerWithIdentifier:[self->_viewControllerIdentifiers firstObject]];
            [self setupViewController:startingViewController];

            // Add it the the page controller.
            [self setViewControllers:@[startingViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        }
    }
}

#pragma mark - Logic

- (void)setupViewController:(UIViewController<CVPageContentViewController> *)viewController {
    if ([viewController respondsToSelector:@selector(allowsPaging)]) {
        [viewController addObserver:self
                         forKeyPath:NSStringFromSelector(@selector(allowsPaging))
                            options:0
                            context:NULL];
    }
    if ([viewController respondsToSelector:@selector(isFinished)]) {
        [viewController addObserver:self
                         forKeyPath:NSStringFromSelector(@selector(isFinished))
                            options:0
                            context:NULL];
    }

    viewController.view.frame = self.view.frame;
}

/**
 *  Helper method to instantiate a storyboard view controller from its identifier.
 *
 *  @param identifier The identifier of the view controller to instantiate.
 *
 *  @return The instantiated view controller.
 */
- (UIViewController<CVPageContentViewController> *)viewControllerWithIdentifier:(NSString *)identifier {
    return [self.storyboard instantiateViewControllerWithIdentifier:identifier];
}

/**
 *  Helper method to return the view controller for a given page controller
 *  index.
 *
 *  @param index The index of the view controller to return.
 *
 *  @return The view controller at the given index.
 */
- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    NSArray *viewControllerIdentifiers = self.viewControllerIdentifiers;

    // If the number of identifiers is invalid return nil.
    NSUInteger numIdentifiers = [viewControllerIdentifiers count];

    if ((numIdentifiers == 0) || (index >= numIdentifiers)) {
        return nil;
    }

    NSString *identifier = viewControllerIdentifiers[index];

    // Instantiate the view controller and set its page index.
    UIViewController<CVPageContentViewController> *viewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];

    [self setupViewController:viewController];

    viewController.pageIndex = index;

    return viewController;
}

- (void)setScrollEnabled:(BOOL)enabled {
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)view setScrollEnabled : enabled];
            return;
        }
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(CVPageContentNavigationController *)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(allowsPaging))]) {
        [self setScrollEnabled:object.allowsPaging];
    }

    if ([keyPath isEqualToString:NSStringFromSelector(@selector(isFinished))]) {
        if (object.isFinished) {
            @try
            {
                [object removeObserver:self forKeyPath:NSStringFromSelector(@selector(allowsPaging))];
                [object removeObserver:self forKeyPath:NSStringFromSelector(@selector(isFinished))];
            }
            @catch (NSException *__unused exception) {}
        }
    }
}

#pragma mark - Page View Controller

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController<CVPageContentViewController> *)viewController {
    NSUInteger index = viewController.pageIndex;

    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }

    index--;

    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController<CVPageContentViewController> *)viewController {
    NSUInteger index = viewController.pageIndex;

    if (index == NSNotFound) {
        return nil;
    }

    index++;

    if (index == [self.viewControllerIdentifiers count]) {
        return nil;
    }

    return [self viewControllerAtIndex:index];
}

@end
