//  CVPageContentSplitViewController.h
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 12/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "CVPageContentViewController.h"

#import "CVExperienceObject.h"

@interface CVPageContentSplitViewController : UIViewController <CVPageContentViewController>

- (NSString *)detailSegueIdentifier;

- (void)updateDetailControllerWithExperienceObject:(CVExperienceObject *)experienceObject;

@end
