//
//  CVTimelineTableViewController.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVTimelineTableViewController.h"

#import "CVDetailViewController.h"

#import "CVTimelineEventTableViewCell.h"

/// Cell identifier for major events.
static NSString *CVMajorEventTableCellIdentifier = @"Major Event Cell";
/// Cell identifier for minor events.
static NSString *CVMinorEventTableCellIdentifier = @"Minor Event Cell";

@implementation CVTimelineTableViewController

@synthesize pageIndex = _pageIndex;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"ExperienceTitle", nil);

    self.clearsSelectionOnViewWillAppear = IS_IPHONE;

    NSArray *events = [CVTimelineEvent timetableEvents];
    [self setData:events containsSections:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (IS_IPAD) {
        NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self tableView:self.tableView didSelectRowAtIndexPath:firstIndexPath];
        [self.tableView selectRowAtIndexPath:firstIndexPath animated:animated scrollPosition:UITableViewScrollPositionTop];
    }
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:CVDetailSegueIdentifier]
        && IS_IPHONE) {
        CVDetailViewController *detailViewController = segue.destinationViewController;
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        detailViewController.experience = [self objectAtIndexPath:selectedIndexPath];
    }
}

#pragma mark - Table View

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath {
    CVTimelineEvent *event = [self objectAtIndexPath:indexPath];
    NSString *CellIdentifier = [super cellIdentifierForIndexPath:indexPath];

    // Set the appropriate cell identifier base on importance of the event.
    if (event.importance == CVTimelineEventImportanceMajor) {
        CellIdentifier = CVMajorEventTableCellIdentifier;
    } else if (event.importance == CVTimelineEventImportanceMinor) {
        CellIdentifier = CVMinorEventTableCellIdentifier;
    }

    return CellIdentifier;
}

- (void) listView:(id)listView
    configureCell:(CVTimelineEventTableViewCell *)cell
       withObject:(CVTimelineEvent *)event
      atIndexPath:(NSIndexPath *)indexPath {
    cell.event = event;
}

- (void)   listView:(id)listView
    didSelectObject:(id)object
        atIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(timelineViewController:didSelectExperience:)]) {
        [self.delegate timelineViewController:self
                          didSelectExperience:object];
    }

    if (IS_IPHONE) {
        [self performSegueWithIdentifier:CVDetailSegueIdentifier
                                  sender:self];
    }
}

@end
