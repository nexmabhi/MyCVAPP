//
//  CVPageViewController.h
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import <UIKit/UIKit.h>

@class CVPageViewController;

/**
 *  Subclass of UIPageViewController which handles the paging structure
 *  and dataSource.
 */
@interface CVPageViewController : UIPageViewController

/// The controller storyboard identifiers passed on for each page content controller.
@property (nonatomic, strong) NSArray *viewControllerIdentifiers;

@end
