//
//  CVExtractedObject.h
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import <Foundation/Foundation.h>

/**
 *  Abstract object to help extract data from a resource and convert it
 *  to objects.
 */
@interface CVExtractedObject : NSObject

/**
 *  Extracts the data from a plist into an array of CVExtractedObjects.
 *  The plist must be formatter with a root object as an Array and
 *  each element as a Dictionary for this method to be successful.
 *  NOTE: If the method returns nil check the error parameter.
 *
 *  @param error    An error is allocated if something went wrong.
 *
 *  @return An array of CVExtractedObjects from the resource data.
 */
+ (NSArray *)extraObjects:(NSError *__autoreleasing *)error;

+ (NSString *)filePathForResource;

+ (UIImage *)loadBackgroundImage:(NSDictionary *)backgroundImageInfo;

/**
 *  Creates an instance from a dictionary.
 *
 *  @param dictionary The dictionary to populate the instance from.
 *
 *  @return A populated CVExtractedObject.
 */
- (instancetype)initFromDictionary:(NSDictionary *)dictionary;

@end
