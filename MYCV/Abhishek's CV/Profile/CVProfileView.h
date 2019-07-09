//
//  CVProfileView.h
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "CVPersonalInfo.h"

@class CVProfileView;

/**
 *  Delegate protocol which may give notice when the info button is pressed.
 */
@protocol CVProfileViewDelegate <NSObject>

@optional
/**
 *  The profile view did select the info button. In this app the profile
 *  view should expand to the full view.
 *
 *  @param profileView The profile view who's button is triggered.
 */
- (void)profileViewDidSelectInfoButton:(CVProfileView *)profileView;
/**
 *  The profile view did select the close button. In this app the profile
 *  view should retract to its initial size.
 *
 *  @param profileView The profile view who's button is triggered.
 */
- (void)profileViewDidSelectCloseButton:(CVProfileView *)profileView;
@end

@protocol CVProfileViewDataSource <NSObject>

@optional
- (UIViewController *)controllerForEmailPresentationInProfileView:(CVProfileView *)profileView;

@end

/**
 *  The profile view which contains the about me section.
 */
@interface CVProfileView : UIView <UILayoutSupport>

/// The delegate property.
@property (nonatomic, weak) id<CVProfileViewDelegate> delegate;
@property (nonatomic, weak) id<CVProfileViewDataSource> dataSource;
/// The label describing the current views seen by the user.
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView;

@property (nonatomic, strong) CVPersonalInfo *personalInfo;

/// Flag set whenever the view has been expanded.
@property (nonatomic, readonly) BOOL expanded;

- (void)handleBackgroundImageBlur:(BOOL)animated;

@end
