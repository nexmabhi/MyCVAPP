//
//  CVExtraCurricularActivity.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVExtraCurricularActivity.h"

@implementation CVExtraCurricularActivity

+ (NSArray *)extraCurricularActivities {
    NSError *error = nil;
    NSArray *activities = [super extraObjects:&error];

    if (error != nil) {
        [error handle];
        return nil;
    }

    NSSortDescriptor *startDateSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startDate" ascending:NO];
    NSSortDescriptor *endDateSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"endDate" ascending:NO];

    return [activities sortedArrayUsingDescriptors:@[startDateSortDescriptor, endDateSortDescriptor]];
}

+ (NSString *)filePathForResource {
    return [[NSBundle mainBundle] pathForResource:@"Extra Curricular" ofType:@"plist"];
}

- (instancetype)initFromDictionary:(NSDictionary *)dictionary {
    self = [super initFromDictionary:dictionary];
    if (self) {
    }
    return self;
}

@end
