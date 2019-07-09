//
//  CVListViewController.h
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 13/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol CVListViewController <NSObject>

/// The data for the list view. The format will always include multiple
/// sections. To set data (for single section & multiple sections) please
/// use setData:containsSections:.
@property (nonatomic, strong, readonly) NSArray *data;

/**
 *  Custom setter to allow for data sources formatted for multiple
 *  sections or a singular section.
 *
 *  @param data             The given data to display.
 *  @param containsSections A flag set if the data given has been formatted for
 *                          multiple sections.
 */
- (void)setData:(NSArray *)data containsSections:(BOOL)containsSections;

/**
 *  Returns the object from the data source associated with the given
 *  index path.
 *
 *  @param indexPath The index path of the object in the data source.
 *
 *  @return The object at the given index path.
 */
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Helper method to configure a cell at the given index path with a given
 *  object.
 *
 *  @param listView The list view who's cell is configured.
 *  @param cell      The cell to configure.
 *  @param object    The object which matches the cell's index path.
 *  @param indexPath The index path of the cell to configure.
 */
- (void)listView:(id)listView configureCell:(id)cell withObject:(id)object atIndexPath:(NSIndexPath *)indexPath;

/**
 *  Called when the user selects a cell a the given index path.
 *
 *  @param listView The list view who is interacted with.
 *  @param object    The object at the selected index path.
 *  @param indexPath The index path of the cell which was selected.
 */
- (void)listView:(id)listView didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath;

/**
 *  The cell identifier for the given index path.
 *
 *  @param indexPath The index path of the cell.
 *
 *  @return The cell identifier.
 */
- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath;

@end
