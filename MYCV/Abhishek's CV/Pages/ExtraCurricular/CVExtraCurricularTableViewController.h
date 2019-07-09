//
//  CVExtraCurricularTableViewController.h
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "JOTableViewController.h"

#import "CVPageContentViewController.h"

@class CVExperienceObject;
@class CVExtraCurricularTableViewController;

static NSString *CVDetailSegueIdentifier = @"Extra Curricular Detail Segue";

@protocol CVExtraCurricularTableViewControllerDelegate <NSObject>

@optional
- (void)extraCurricularViewController:(CVExtraCurricularTableViewController *)controller
                  didSelectExperience:(CVExperienceObject *)experience;

@end

@interface CVExtraCurricularTableViewController : JOTableViewController <CVPageContentViewController>

@property (nonatomic, weak) id<CVExtraCurricularTableViewControllerDelegate> delegate;

@end
