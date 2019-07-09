//  JOCollectionViewController.m
//
//  Created by Abhishek Dsilva on 13/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "JOCollectionViewController.h"

static NSString *CVTableDefaultCellIdentifier = @"Cell";

@interface JOCollectionViewController ()

@property (nonatomic, strong) NSArray *data;

@end

@implementation JOCollectionViewController

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

#pragma mark - Collection View

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.data count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.data[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Get identifers from overridable method.
    NSString *CellIdentifier = [self cellIdentifierForIndexPath:indexPath];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    // Get object from overridable method.
    id object = [self objectAtIndexPath:indexPath];

    // Configure the cell from overridable method.
    [self listView:collectionView configureCell:cell withObject:object atIndexPath:indexPath];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // Get object from overridable method.
    id object = [self objectAtIndexPath:indexPath];

    // Call overridable method.
    [self listView:collectionView didSelectObject:object atIndexPath:indexPath];
}

@end
