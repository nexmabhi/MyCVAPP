//  CVReferee.m
//
//  Created by Abhishek Dsilva on 13/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVReferee.h"

@implementation CVReferee

+ (NSArray *)referees {
    NSError *error = nil;
    NSArray *referees = [super extraObjects:&error];

    if (error != nil) {
        [error handle];
        return nil;
    }

    return referees;
}

+ (NSString *)filePathForResource {
    return [[NSBundle mainBundle] pathForResource:@"Referees" ofType:@"plist"];
}

- (instancetype)initFromDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.title = dictionary[@"title"];
        self.firstName = dictionary[@"firstName"];
        self.lastName = dictionary[@"lastName"];
        self.position = dictionary[@"position"];
        self.location = dictionary[@"location"];
        self.connection = dictionary[@"connection"];
        self.phoneNumber = dictionary[@"phoneNumber"];
        self.email = dictionary[@"email"];
        self.picture = [UIImage imageNamed:dictionary[@"imageName"]];
    }
    return self;
}

- (NSString *)fullName {
    NSMutableString *fullName = [[NSMutableString alloc] init];

    if (self.title) {
        [fullName appendFormat:@"%@ ", self.title];
    }

    [fullName appendFormat:@"%@ %@", self.firstName, self.lastName];

    return fullName;
}

@end
