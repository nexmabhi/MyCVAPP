//
//  CVTimelineEventTableViewCell.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 10/04/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//


#import "CVTimelineEventTableViewCell.h"

#import "JOCircleView.h"

@interface CVTimelineEventTableViewCell ()

@property (nonatomic, weak) IBOutlet JOCircleView *dotView;
@property (nonatomic, weak) IBOutlet UIView *lineView;

@property (nonatomic, weak) IBOutlet UILabel *positionLabel;
/// The description label for the event.
@property (nonatomic, weak) IBOutlet UILabel *organisationLabel;
/// The date label for the event.
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

@end

@implementation CVTimelineEventTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    if (IS_IPHONE) {
        UIImage *chevronImage = [UIImage imageNamed:@"chevron"];
        chevronImage = [chevronImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *chevronImageView = [[UIImageView alloc] initWithImage:chevronImage];
        [chevronImageView sizeToFit];
        self.accessoryView = chevronImageView;
    }

    UIView *backgroundView = [[UIView alloc] initWithFrame:self.frame];
    backgroundView.backgroundColor = [UIColor backgroundGrayColor];
    self.selectedBackgroundView = backgroundView;
}

#pragma mark - Setters & Getters

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.lineView.backgroundColor = [UIColor lightGrayColor];
    self.dotView.backgroundColor = self.event.color;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];

    self.lineView.backgroundColor = [UIColor lightGrayColor];
    self.dotView.backgroundColor = self.event.color;
}

- (void)setEvent:(CVTimelineEvent *)event {
    if (self->_event != event) {
        self->_event = event;

        // Set the UI elements from the event.
        self.organisationLabel.text = event.organisation;
        self.positionLabel.text = event.position;

        self.dateLabel.text = [event.startDate combinedCondensedStringWithEndDate:event.endDate withMidString:@" -\n  "];

        UIColor *tintColor = event.color;
        self.dateLabel.textColor = tintColor;
        self.organisationLabel.textColor = tintColor;
        self.positionLabel.textColor = tintColor;
        self.dotView.backgroundColor = tintColor;
        self.accessoryView.tintColor = tintColor;
    }
}

@end
