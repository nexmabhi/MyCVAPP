//  CVExperienceObject.m
//
//  Created by Abhishek Dsilva on 13/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVExperienceObject.h"

@implementation CVExperienceObject

- (instancetype)initFromDictionary:(NSDictionary *)dictionary {
    self = [super initFromDictionary:dictionary];
    if (self) {
        self.startDate = dictionary[@"startDate"];
        self.endDate = dictionary[@"endDate"];
        self.organisation = dictionary[@"organisation"];
        self.position = dictionary[@"position"];
        self.detailedDescription = dictionary[@"description"];

        NSString *imageName = dictionary[@"imageName"];
        if (imageName != nil) {
            self.organisationImage = [UIImage imageNamed:imageName];
        }
    }
    return self;
}

@end
