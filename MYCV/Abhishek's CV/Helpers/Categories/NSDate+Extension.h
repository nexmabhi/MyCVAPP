//
//  NSDate+Extension.h
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSDate (Extension)

- (NSString *)stringFromFormatter:(void (^)(NSDateFormatter *formatter))formatterBlock;

- (NSString *)condensedString;

- (NSString *)combinedCondensedStringWithEndDate:(NSDate *)endDate
                                   withMidString:(NSString *)midString;

@end
