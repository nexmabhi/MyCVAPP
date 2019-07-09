//
//  CVPagingConstants.h
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 1/06/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//

#ifndef Abhishek_s_CV_CVPagingConstants_h
#define Abhishek_s_CV_CVPagingConstants_h

typedef NS_ENUM (NSInteger, CVPagingState) {
    CVPagingStateStatic,
    CVPagingStateBeganScroll,
    CVPagingStateFinishedScroll
};

static NSString *const CVPagingNotification = @"CVPagingNotification";
static NSString *const CVPagingStateKey = @"CVPagingStateKey";
static NSString *const CVPagingControllersKey = @"CVPagingControllersKey";

#endif
