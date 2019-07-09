//
//  CVTimelineEvent.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVTimelineEvent.h"

@implementation CVTimelineEvent

+ (NSArray *)timetableEvents {
    NSError *error = nil;
    NSArray *events = [super extraObjects:&error];

    if (error != nil) {
        [error handle];
        return nil;
    }

    NSSortDescriptor *startDateSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startDate" ascending:NO];
    NSSortDescriptor *endDateSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"endDate" ascending:NO];

    return [events sortedArrayUsingDescriptors:@[startDateSortDescriptor, endDateSortDescriptor]];
}

+ (NSString *)filePathForResource {
    return [[NSBundle mainBundle] pathForResource:@"Experience" ofType:@"plist"];
}

- (instancetype)initFromDictionary:(NSDictionary *)dictionary {
    self = [super initFromDictionary:dictionary];
    if (self) {
        self.color = [UIColor colorFromString:dictionary[@"color"]];
        self.importance = [dictionary[@"importance"] integerValue];
    }
    return self;
}

@end
