//  CVPersonalInfo.h
//
//  Created by Abhishek Dsilva on 15/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVExperienceObject.h"

@interface CVPersonalInfo : CVExtractedObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *detailDescription;
@property (nonatomic, strong) UIImage *profileImage;
@property (nonatomic, strong) UIImage *backgroundImage;

@property (nonatomic, strong, readonly) NSString *fullName;

+ (CVPersonalInfo *)personalInfo;

@end
