//
//  CVTimelineEvent.h
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVExperienceObject.h"

/**
 *  The level of importance of the event.
 */
typedef NS_ENUM (NSInteger, CVTimelineEventImportance) {
    /// Importance not set.
    CVTimelineEventImportanceNone,
    /// Big event, usually start of work somewhere.
    CVTimelineEventImportanceMajor,
    /// Small event, usually end of work somewhere.
    CVTimelineEventImportanceMinor
};

/**
 *  An object representing an event in my work experience.
 */
@interface CVTimelineEvent : CVExperienceObject

@property (nonatomic, strong) UIColor *color;

/// Importance of the event.
@property (nonatomic) CVTimelineEventImportance importance;

/**
 *  Returns an array of CVTimelineEvent from the resource data.
 *
 *  @return An array of CVTimelineEvent populated from the resource data.
 */
+ (NSArray *)timetableEvents;

@end
