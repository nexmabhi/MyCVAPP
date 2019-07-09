//
//  CVTimelineEventTableViewCell.h
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "CVTimelineEvent.h"

/**
 *  Timeline cell displaying a single event.
 */
@interface CVTimelineEventTableViewCell : UITableViewCell

/// The event to display in the cell.
@property (nonatomic, strong) CVTimelineEvent *event;

@end
