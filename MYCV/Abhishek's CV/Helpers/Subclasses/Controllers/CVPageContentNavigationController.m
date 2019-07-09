//  CVPageContentNavigationController.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 12/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVPageContentNavigationController.h"

@implementation CVPageContentNavigationController

@synthesize pageIndex = _pageIndex;
@synthesize allowsPaging = _allowsPaging;
@synthesize isFinished = _isFinished;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationBarHidden = YES;
}

- (void)dealloc {
    if ([self respondsToSelector:@selector(isFinished)]) {
        self.isFinished = YES;
    }
}

@end
