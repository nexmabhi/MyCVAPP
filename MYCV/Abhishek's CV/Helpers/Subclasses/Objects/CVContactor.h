//  CVContactor.h
//
//  Created by Abhishek Dsilva on 15/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface CVContactor : NSObject

+ (instancetype)sharedContactor;

+ (void)callNumber:(NSString *)number;

- (void)emailReciepients:(NSArray *)reciepients
            inController:(UIViewController *)controller;

@end
