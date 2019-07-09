//  CVAboutMeView.h
//
//  Created by Abhishek Dsilva on 12/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import <UIKit/UIKit.h>

@class CVPersonalInfo;

@interface CVAboutMeView : UIView

@property (nonatomic, strong) UIViewController *emailPresentController;

@property (nonatomic, strong) CVPersonalInfo *personalInfo;

@end
