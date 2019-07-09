//
//  NSError+Extension.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 13/01/2019.
//  Copyright (c) 2019 Abhishek. All rights reserved.
//


#import "NSError+Extension.h"

@implementation NSError (Extension)

- (void)handle {
#if DEBUG
    NSString *title = [[NSString alloc] initWithFormat:@"Error %li", (long)[self code]];
    NSString *message = [[NSString alloc] initWithFormat:@"%@ %@ %@", [self localizedDescription], [self localizedFailureReason], [self localizedRecoverySuggestion]];

    UIAlertView *errorAV = [[UIAlertView alloc] initWithTitle:title
                                                      message:message
                                                     delegate:nil
                                            cancelButtonTitle:@"Dismiss"
                                            otherButtonTitles:nil];
    [errorAV show];
#else
    NSLog(@"Error %li - %@ %@. %@", (long)[self code], [self localizedDescription], [self localizedFailureReason], [self localizedRecoverySuggestion]);
#endif
}

@end
