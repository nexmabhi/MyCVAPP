//
//  CVTutorialSwipeView.m
//   Abhishek's CV
//
//  Created by Abhishek Dsilva on 6/08/2019.
//  Copyright (c) 2019 Abhishek Dsilva. All rights reserved.
//

#import "CVTutorialSwipeView.h"

#import "JOCircleView.h"

typedef NS_ENUM (NSInteger, CVTutorialCircleSwipeDirection) {
    CVTutorialCircleSwipeDirectionLeft,
    CVTutorialCircleSwipeDirectionRight
};

@interface CVTutorialSwipeView ()

@property (nonatomic, strong) JOCircleView *circleView;

@property (nonatomic, assign) BOOL endOnNextLoop;

@end

@implementation CVTutorialSwipeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    JOCircleView *circleView = [[JOCircleView alloc] init];
    circleView.backgroundColor = [UIColor backgroundGrayColor];
    [self addSubview:circleView];
    
    CGRect circleViewFrame = circleView.frame;
    circleViewFrame.size = CGSizeMake(44.0f, 44.0f);
    circleViewFrame.origin.x = 0.0;
    circleView.frame = circleViewFrame;
    [circleView centerVerticallyWithReferenceRect:self.bounds];

    self.circleView = circleView;
}

- (void)startAnimating {
    self.endOnNextLoop = NO;
    [self animateMovementWithDirection:CVTutorialCircleSwipeDirectionRight];
}

- (void)endAnimatingOnNextAnimationLoop {
    self.endOnNextLoop = YES;
}

- (void)animateMovementWithDirection:(CVTutorialCircleSwipeDirection)direction {
    CGRect bounds = self.bounds;
    JOCircleView *circleView = self.circleView;

    CVTutorialCircleSwipeDirection nextDirection;
    CGFloat toX = 0.0f;
    if (direction == CVTutorialCircleSwipeDirectionLeft) {
        toX = 0.0f;
        nextDirection = CVTutorialCircleSwipeDirectionRight;
    } else {
        toX = bounds.size.width - circleView.frame.size.width;
        nextDirection = CVTutorialCircleSwipeDirectionLeft;
    }
    
    CGRect circleViewFrame = circleView.frame;
    circleViewFrame.origin.x = toX;
    
    [UIView animateWithDuration:0.9 animations:^{
        circleView.frame = circleViewFrame;
    } completion:^(BOOL finished) {
        __weak __typeof(circleView) weakCircleView = circleView;
        [circleView setHidden:YES animated:YES duration:1.6 completion:^(BOOL finished) {
            __strong __typeof(weakCircleView) strongCircleView = weakCircleView;
           [strongCircleView setHidden:NO animated:YES duration:1.6 completion:^(BOOL finished) {
               if (self.endOnNextLoop == NO)
                   [self animateMovementWithDirection:nextDirection];
           }];
        }];
    }];
}

@end
