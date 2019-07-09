//
//  CVRefereeCollectionViewCell.h
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "CVReferee.h"

@class CVRefereeCollectionViewCell;

@protocol CVRefereeCollectionViewCellDelegate <NSObject>

- (void)refereeCell:(CVRefereeCollectionViewCell *)refereeCell didSelectToCallReferee:(CVReferee *)referee;
- (void)refereeCell:(CVRefereeCollectionViewCell *)refereeCell didSelectToEmailReferee:(CVReferee *)referee;

@end

@interface CVRefereeCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<CVRefereeCollectionViewCellDelegate> delegate;

@property (nonatomic, strong) CVReferee *referee;

@end
