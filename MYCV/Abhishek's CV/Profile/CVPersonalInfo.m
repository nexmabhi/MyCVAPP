//  CVPersonalInfo.m
//
//  Created by Abhishek Dsilva on 15/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVPersonalInfo.h"

@implementation CVPersonalInfo

+ (CVPersonalInfo *)personalInfo {
    NSError *error = nil;
    NSArray *personalInfo = [self extraObjects:&error];

    if (error) {
        [error handle];
        return nil;
    }

    return [personalInfo firstObject];
}

+ (NSString *)filePathForResource {
    return [[NSBundle mainBundle] pathForResource:@"About Me" ofType:@"plist"];
}

- (instancetype)initFromDictionary:(NSDictionary *)dictionary {
    self = [super initFromDictionary:dictionary];
    if (self) {
        self.firstName = dictionary[@"firstName"];
        self.lastName = dictionary[@"lastName"];
        self.location = dictionary[@"location"];
        self.phoneNumber = dictionary[@"phoneNumber"];
        self.email = dictionary[@"email"];
        self.detailDescription = dictionary[@"description"];
        self.profileImage = [UIImage imageNamed:dictionary[@"imageName"]];

        NSDictionary *backgroundImageInfo = dictionary[@"backgroundImageInfo"];
        self.backgroundImage = [CVExtractedObject loadBackgroundImage:backgroundImageInfo];
    }
    return self;
}

- (NSString *)fullName {
    return [[NSString alloc] initWithFormat:@"%@ %@", self.firstName, self.lastName];
}

@end
