//
//  CVTutorialViewController.h
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 6/08/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CVTutorialViewController : UIViewController

@property (nonatomic, strong) UIImage *backgroundImage;

+ (BOOL)needsToPresentTutorials;

@end
