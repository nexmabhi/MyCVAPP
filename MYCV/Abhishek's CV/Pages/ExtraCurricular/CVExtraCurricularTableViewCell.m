//
//  CVExtraCurricularTableViewCell.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVExtraCurricularTableViewCell.h"

#import "CVRoundedRectImageView.h"

@interface CVExtraCurricularTableViewCell ()

@property (nonatomic, weak) IBOutlet CVRoundedRectImageView *activityImageView;
@property (nonatomic, weak) IBOutlet UILabel *positionLabel;
@property (nonatomic, weak) IBOutlet UILabel *organisationLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

@end

@implementation CVExtraCurricularTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    UIView *backgroundView = [[UIView alloc] initWithFrame:self.frame];
    backgroundView.backgroundColor = [UIColor backgroundGrayColor];
    self.selectedBackgroundView = backgroundView;
}

#pragma mark - Setters & Getters

- (void)setActivity:(CVExtraCurricularActivity *)activity {
    if (self->_activity != activity) {
        self->_activity = activity;

        self.positionLabel.text = activity.position;
        self.activityImageView.image = activity.organisationImage;
        self.organisationLabel.text = activity.organisation;

        self.dateLabel.text = [activity.startDate combinedCondensedStringWithEndDate:activity.endDate withMidString:@" - "];
    }
}

@end
