//
//  CVExtraCurricularTableViewController.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVExtraCurricularTableViewController.h"

#import "CVDetailViewController.h"

#import "CVExtraCurricularTableViewCell.h"

static NSString *CVExtraCurricularTableCellIdentifier = @"Extra Curricular Cell";

@interface CVExtraCurricularTableViewController ()

@end

@implementation CVExtraCurricularTableViewController

@synthesize pageIndex = _pageIndex;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"ExtraCurricularTitle", nil);

    self.clearsSelectionOnViewWillAppear = !IS_IPAD;

    NSArray *activities = [CVExtraCurricularActivity extraCurricularActivities];
    [self setData:activities containsSections:NO];
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
    return CVExtraCurricularTableCellIdentifier;
}

- (void) listView:(id)listView
    configureCell:(CVExtraCurricularTableViewCell *)cell
       withObject:(CVExtraCurricularActivity *)activity
      atIndexPath:(NSIndexPath *)indexPath {
    cell.activity = activity;
}

- (void)   listView:(id)listView
    didSelectObject:(CVExtraCurricularActivity *)activity
        atIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(extraCurricularViewController:didSelectExperience:)]) {
        [self.delegate extraCurricularViewController:self
                                 didSelectExperience:activity];
    }
}

@end
