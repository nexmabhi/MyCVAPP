//
//  NSDate+Extension.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "NSDate+Extension.h"

static NSString *CVCondensedDateFormat = @"MMM YY";

@implementation NSDate (Extension)

- (NSString *)stringFromFormatter:(void (^)(NSDateFormatter *formatter))formatterBlock {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
    });

    if (formatterBlock) {
        formatterBlock(formatter);
    }

    return [formatter stringFromDate:self];
}

- (NSString *)condensedString {
    return [self stringFromFormatter:^(NSDateFormatter *formatter) {
        [formatter setDateFormat:CVCondensedDateFormat];
    }];
}

- (NSString *)combinedCondensedStringWithEndDate:(NSDate *)endDate
                                   withMidString:(NSString *)midString {
    NSString *startDateText = [self condensedString];

    if ([endDate compare:[NSDate date]] == NSOrderedDescending) {
        return [[NSString alloc] initWithFormat:@"%@%@%@", startDateText, midString, NSLocalizedString(@"PresentDate", nil)];
    } else {
        NSString *endDateText = [endDate condensedString];
        if ([startDateText isEqualToString:endDateText]) {
            return startDateText;
        } else {
            return [[NSString alloc] initWithFormat:@"%@%@%@", startDateText, midString, endDateText];
        }
    }
}

@end
