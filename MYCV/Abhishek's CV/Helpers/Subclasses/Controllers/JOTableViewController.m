//
//  JOTableViewController.m
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "JOTableViewController.h"

static NSString *CVTableDefaultCellIdentifier = @"Cell";

@interface JOTableViewController ()

@property (nonatomic, strong) NSArray *data;

@end

@implementation JOTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (IS_IPHONE) {
        UITableView *tableView = self.tableView;

        for (NSIndexPath *selectedIndexPath in [tableView indexPathsForSelectedRows]) {
            [self.tableView deselectRowAtIndexPath:selectedIndexPath animated:animated];
        }
    }
}

#pragma mark - Logic

- (void)setData:(NSArray *)data containsSections:(BOOL)containsSections {
    if (self->_data != data) {
        // If the data is not formatted for multiple sections then assume
        // that is for a singular section and format it accordingly.
        self->_data = (containsSections) ? data : @[data];
    }
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
    return self.data[indexPath.section][indexPath.row];
}

- (void)listView:(id)listView configureCell:(id)cell withObject:(id)object atIndexPath:(NSIndexPath *)indexPath {

}

- (void)listView:(id)listView didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {

}

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath {
    return CVTableDefaultCellIdentifier;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.data count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Get identifers from overridable method.
    NSString *CellIdentifier = [self cellIdentifierForIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    // Get object from overridable method.
    id object = [self objectAtIndexPath:indexPath];

    // Configure the cell from overridable method.
    [self listView:tableView configureCell:cell withObject:object atIndexPath:indexPath];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Get object from overridable method.
    id object = [self objectAtIndexPath:indexPath];

    // Call overridable method.
    [self listView:tableView didSelectObject:object atIndexPath:indexPath];
}

@end
