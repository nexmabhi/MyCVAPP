//
//  JOTableViewController.h
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "CVListViewController.h"

/**
 *  Abstract table view subclass which makes populating a table view from
 *  a data source of object easy and uncomplicated.
 */
@interface JOTableViewController : UITableViewController <CVListViewController>

@end
