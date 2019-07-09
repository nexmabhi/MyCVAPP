//
//  CVReferencesCollectionViewController.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVReferencesCollectionViewController.h"

#import "CVRefereeCollectionViewCell.h"

#import "CVContactor.h"

static NSString *CVRefereeCollectionViewCellIdentifier = @"Referee Cell";

@interface CVReferencesCollectionViewController () <CVRefereeCollectionViewCellDelegate>

@end

@implementation CVReferencesCollectionViewController

@synthesize pageIndex = _pageIndex;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"ReferencesTitle", nil);

    NSArray *referees = [CVReferee referees];
    [self setData:referees containsSections:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath {
    return CVRefereeCollectionViewCellIdentifier;
}

- (void) listView:(id)listView
    configureCell:(CVRefereeCollectionViewCell *)cell
       withObject:(CVReferee *)referee
      atIndexPath:(NSIndexPath *)indexPath {
    cell.delegate = self;
    cell.referee = referee;
}

#pragma mark - Referee Cell Delegate

- (void)refereeCell:(CVRefereeCollectionViewCell *)refereeCell didSelectToCallReferee:(CVReferee *)referee {
    [CVContactor callNumber:referee.phoneNumber];
}

- (void)refereeCell:(CVRefereeCollectionViewCell *)refereeCell didSelectToEmailReferee:(CVReferee *)referee {
    [[CVContactor sharedContactor] emailReciepients:@[referee.email]
                                       inController:self];
}

@end
