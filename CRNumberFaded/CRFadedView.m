//
//  CRFadedView.m
//  CRNumberFaded
//
//  Created by Bear on 17/3/22.
//  Copyright © 2017年 Bear. All rights reserved.
//

#import "CRFadedView.h"

@interface CRFadedView ()

@property (strong, nonatomic) CABasicAnimation *scaleAnimation;
@property (strong, nonatomic) CABasicAnimation *positionAnimation;
@property (strong, nonatomic) CABasicAnimation *opacityAnimation;

@end

@implementation CRFadedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initDefaultParameter];
        [self loadParameterAndCreateUI];
    }
    
    return self;
}

- (void)initDefaultParameter
{
    self.needLabel = @YES;
    self.fadeInRatio = @0.5;
    self.fadeOutRatio = @2;
    self.animationDuration = @0.3;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}



#pragma mark - CreateUI
- (void)loadParameterAndCreateUI
{
    [self createUI];
    [self relayUI];
}

- (void)createUI
{
    if ([self.needLabel boolValue]) {
        [self addSubview:self.label];
    }else{
        [self.label removeFromSuperview];
    }
}

- (void)relayUI
{
    [_label sizeToFit];
    [_label BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
}

#pragma mark - Method
- (void)fadeIn
{
    NSLog(@"--fadeIn");
    self.scaleAnimation.fromValue = self.fadeInRatio;
    self.scaleAnimation.toValue = @1.0;
    [self.layer addAnimation:self.scaleAnimation forKey:self.scaleAnimation.keyPath];
    
    self.positionAnimation.fromValue = self.fadeInOffSetPointValue;
    self.positionAnimation.toValue = [NSValue valueWithCGPoint:self.center];
    [self.layer addAnimation:self.positionAnimation forKey:self.positionAnimation.keyPath];
}

- (void)fadeOut
{
    NSLog(@"--fadeOut");
    self.scaleAnimation.fromValue = @1.0;
    self.scaleAnimation.toValue = self.fadeOutRatio;
    [self.layer addAnimation:self.scaleAnimation forKey:self.scaleAnimation.keyPath];
    
    self.positionAnimation.fromValue = [NSValue valueWithCGPoint:self.center];
    self.positionAnimation.toValue = self.fadeOutOffSetPointValue;
    [self.layer addAnimation:self.positionAnimation forKey:self.positionAnimation.keyPath];
}

#pragma mark - Setter & Getter
- (UILabel *)label
{
    if (!_label) {
        _label = [UILabel new];
    }
    
    return _label;
}

- (CABasicAnimation *)scaleAnimation
{
    if (!_scaleAnimation) {
        _scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        _scaleAnimation.fromValue = @1.0;
        _scaleAnimation.toValue = @1.0;
        _scaleAnimation.fillMode = kCAFillModeForwards;
        _scaleAnimation.removedOnCompletion = NO;
        _scaleAnimation.duration = [self.animationDuration floatValue];
        _scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    }
    
    return _scaleAnimation;
}

- (CABasicAnimation *)positionAnimation
{
    if (!_positionAnimation) {
        _positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
//        _positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
        _positionAnimation.fillMode = kCAFillModeForwards;
        _positionAnimation.removedOnCompletion = NO;
        _positionAnimation.duration = [self.animationDuration floatValue];
        _positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    }
    
    return _positionAnimation;
}

- (CABasicAnimation *)opacityAnimation
{
    if (!_opacityAnimation) {
        _opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        _opacityAnimation.fillMode = kCAFillModeForwards;
        _opacityAnimation.removedOnCompletion = NO;
        _opacityAnimation.duration = [self.animationDuration floatValue];
        _opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    }
    
    return _opacityAnimation;
}

- (NSValue *)fadeOutOffSetPointValue
{
    if (!_fadeOutOffSetPointValue) {
        _fadeOutOffSetPointValue = [NSValue valueWithCGPoint:CGPointMake(self.centerX - 20, self.centerY)];
    }
    
    return _fadeOutOffSetPointValue;
}

- (NSValue *)fadeInOffSetPointValue
{
    if (!_fadeInOffSetPointValue) {
        _fadeInOffSetPointValue = [NSValue valueWithCGPoint:CGPointMake(self.centerX + 20, self.centerY)];
    }
    
    return _fadeInOffSetPointValue;
}

@end
