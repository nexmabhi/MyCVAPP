//
//  CVExtractedObject.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVExtractedObject.h"

@implementation CVExtractedObject

+ (NSArray *)extraObjects:(NSError *__autoreleasing *)error {
    NSString *filePath = [self filePathForResource];

    NSPropertyListFormat plistFormat = 0;
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    id allInfo = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:&plistFormat error:error];

    NSMutableArray *objects = nil;

    if ([allInfo isKindOfClass:[NSArray class]]) {
        objects = [[NSMutableArray alloc] initWithCapacity:[allInfo count]];

        // For each of the resource create an new object.
        for (id info in allInfo) {
            if (![info respondsToSelector:@selector(objectForKey:)]) {
                return nil;
            }

            CVExtractedObject *object = [[[self class] alloc] initFromDictionary:info];
            [objects addObject:object];
        }
    } else if ([allInfo isKindOfClass:[NSDictionary class]]) {
        objects = [[NSMutableArray alloc] initWithCapacity:1];
        [objects addObject:[[[self class] alloc] initFromDictionary:allInfo]];
    } else {
        return nil;
    }

    return objects;
}

+ (NSString *)filePathForResource {
    return nil;
}

+ (UIImage *)loadBackgroundImage:(NSDictionary *)backgroundImageInfo {
    NSString *backgroundImageName = backgroundImageInfo[@"name"];
    NSString *backgroundImageExtension = backgroundImageInfo[@"extension"];

    NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:backgroundImageName ofType:backgroundImageExtension];

    return [[UIImage alloc] initWithContentsOfFile:backgroundImagePath];
}

- (instancetype)initFromDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {

    }
    return self;
}

@end
