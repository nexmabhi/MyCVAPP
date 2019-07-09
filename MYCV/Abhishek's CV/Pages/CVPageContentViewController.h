//
//  CVPageContentViewController.h
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import <Foundation/Foundation.h>

/**
 *  Protocol for each page content controller to abide to.
 */
@protocol CVPageContentViewController <NSObject>

/// The page number for the particular page controller.
@property (nonatomic) NSInteger pageIndex;

@optional
@property (nonatomic) BOOL allowsPaging;
@property (nonatomic) BOOL isFinished;

@end
