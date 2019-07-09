//
//  CVTimelineTableViewController.h
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "JOTableViewController.h"

#import "CVPageContentViewController.h"

@class CVExperienceObject;
@class CVTimelineTableViewController;

static NSString *CVDetailSegueIdentifier = @"Experience Detail Segue";

@protocol CVTimelineTableViewControllerDelegate <NSObject>

@optional
- (void)timelineViewController:(CVTimelineTableViewController *)controller
           didSelectExperience:(CVExperienceObject *)experience;

@end

/**
 *  The timeline table view controller displaus a graphical timeline for
 *  my work experience.
 */
@interface CVTimelineTableViewController : JOTableViewController <CVPageContentViewController>

@property (nonatomic, weak) id<CVTimelineTableViewControllerDelegate> delegate;

@end
