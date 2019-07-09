//  CVExperienceObject.h
//
//  Created by Abhishek Dsilva on 13/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVExtractedObject.h"

@interface CVExperienceObject : CVExtractedObject

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

@property (nonatomic, strong) NSString *organisation;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) UIImage *organisationImage;

@property (nonatomic, strong) NSString *detailedDescription;

@end
