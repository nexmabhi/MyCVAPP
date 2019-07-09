//  CVReferee.h
//
//  Created by Abhishek Dsilva on 13/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVExtractedObject.h"

@interface CVReferee : CVExtractedObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *connection;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) UIImage *picture;

@property (nonatomic, strong, readonly) NSString *fullName;

+ (NSArray *)referees;

@end
