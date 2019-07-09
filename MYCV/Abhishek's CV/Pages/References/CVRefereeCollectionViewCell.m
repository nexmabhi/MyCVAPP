//
//  CVRefereeCollectionViewCell.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVRefereeCollectionViewCell.h"

#import "JOCircleImageView.h"

@interface CVRefereeCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *fullNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *positionLabel;
@property (nonatomic, weak) IBOutlet UILabel *locationlabel;
@property (nonatomic, weak) IBOutlet UILabel *connectionLabel;
@property (nonatomic, weak) IBOutlet UIButton *phoneButton;
@property (nonatomic, weak) IBOutlet UIButton *emailButton;
@property (nonatomic, weak) IBOutlet JOCircleImageView *pictureImageView;

@property (nonatomic, weak) IBOutlet UIImageView *cardBackgroundImageView;

@end

@implementation CVRefereeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    UIImage *cardImage = [UIImage imageNamed:@"conatct-card"];
    UIImage *strechedImage = [cardImage resizableImageWithCapInsets:UIEdgeInsetsMake(3.0f, 4.0f, 6.0f, 4.0f) resizingMode:UIImageResizingModeStretch];
    self.cardBackgroundImageView.image = strechedImage;

    self.emailButton.enabled = [UIApplication emailAvailable];
    self.phoneButton.enabled = [UIApplication phoneAvailable];
}

#pragma mark - Setters & Getters

- (void)setReferee:(CVReferee *)referee {
    if (self->_referee != referee) {
        self->_referee = referee;

        self.fullNameLabel.text = referee.fullName;
        self.positionLabel.text = referee.position;
        self.locationlabel.text = referee.location;
        self.connectionLabel.text = referee.connection;

        [self.phoneButton setTitle:referee.phoneNumber forState:UIControlStateNormal];
        [self.emailButton setTitle:referee.email forState:UIControlStateNormal];

        self.pictureImageView.image = referee.picture;
    }
}

#pragma mark - Actions

- (IBAction)phoneAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(refereeCell:didSelectToCallReferee:)]) {
        [self.delegate refereeCell:self didSelectToCallReferee:self.referee];
    }
}

- (IBAction)emailAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(refereeCell:didSelectToEmailReferee:)]) {
        [self.delegate refereeCell:self didSelectToEmailReferee:self.referee];
    }
}

@end
