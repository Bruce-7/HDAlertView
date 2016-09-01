//
//  HDAlertView.m
//  Seven
//
//  Created by HeDong on 16/9/1.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "HDAlertView.h"
#import "UIView+HDExtension.h"
#import "UIImage+HDExtension.h"
#import "NSString+HDExtension.h"

NSString *const HDAlertViewWillShowNotification     = @"HDAlertViewWillShowNotification";
NSString *const HDAlertViewDidShowNotification      = @"HDAlertViewDidShowNotification";
NSString *const HDAlertViewWillDismissNotification  = @"HDAlertViewWillDismissNotification";
NSString *const HDAlertViewDidDismissNotification   = @"HDAlertViewDidDismissNotification";



#pragma mark - HDAlertItem
@interface HDAlertItem : NSObject

/** 按钮标题 */
@property (nonatomic, copy) NSString *title;
/** 按钮风格 */
@property (nonatomic, assign) HDAlertViewButtonType type;
/** 对应按钮行动的处理 */
@property (nonatomic, copy) HDAlertViewHandler action;

@end


@implementation HDAlertItem

@end



#pragma mark - HDAlertWindow
@interface HDAlertWindow : UIWindow

/** Alert背景视图风格 */
@property (nonatomic, assign) HDAlertViewBackgroundStyle style;

@end


@implementation HDAlertWindow

- (instancetype)initWithFrame:(CGRect)frame andStyle:(HDAlertViewBackgroundStyle)style {
    if (self = [super initWithFrame:frame]) {
        self.style = style;
        self.opaque = NO;
        self.windowLevel = 1999.0; // 不重叠系统的Alert, Alert的层级.
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    switch (self.style) {
        case HDAlertViewBackgroundStyleGradient: {
            size_t locationsCount = 2; // unsigned long
            CGFloat locations[2] = {0.0f, 1.0f};
            CGFloat colors[8] = {0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.75f};
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, locationsCount);
            CGColorSpaceRelease(colorSpace);
            
            CGPoint center = CGPointMake(self.hd_width * 0.5, self.hd_height * 0.5);
            CGFloat radius = MIN(self.hd_width, self.hd_height) ;
            CGContextDrawRadialGradient (context, gradient, center, 0, center, radius, kCGGradientDrawsAfterEndLocation);
            CGGradientRelease(gradient);
            break;
        }
            
        case HDAlertViewBackgroundStyleSolid: {
            [[UIColor colorWithWhite:0 alpha:0.1] set];
            CGContextFillRect(context, self.bounds);
            break;
        }
    }
}

@end



#pragma mark - HDAlertView
@interface HDAlertView ()

/** 是否动画 */
@property (nonatomic, assign, getter = isAlertAnimating) BOOL alertAnimating;
/** 是否可见 */
@property (nonatomic, assign, getter = isVisible) BOOL visible;
/** 标题 */
@property (nonatomic, weak) UILabel *titleLabel;
/** 消息描述 */
@property (nonatomic, weak) UILabel *messageLabel;
/** 容器视图 */
@property (nonatomic, weak) UIView *containerView;
/** 存放行动items */
@property (nonatomic, strong) NSMutableArray *items;
/** 存放按钮 */
@property (nonatomic, strong) NSMutableArray *buttons;
/** 展示的背景Window */
@property (nonatomic, strong) HDAlertWindow *alertWindow;

@end


@implementation HDAlertView

+ (void)initialize {
    if (self != [HDAlertView class]) return;
    
    HDAlertView *appearance = [self appearance]; // 设置整体默认外观
    appearance.viewBackgroundColor = [UIColor whiteColor];
    appearance.titleColor = [UIColor blackColor];
    appearance.messageColor = [UIColor darkGrayColor];
    appearance.titleFont = [UIFont boldSystemFontOfSize:18.0];
    appearance.messageFont = [UIFont systemFontOfSize:16.0];
    appearance.buttonFont = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
    appearance.defaultButtonTitleColor = [UIColor blueColor];
    appearance.cancelButtonTitleColor = [UIColor greenColor];
    appearance.destructiveButtonTitleColor = [UIColor redColor];
    appearance.cornerRadius = 10.0;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = HDMainScreenBounds;
        [self setUpSubviews];
    }
    
    return self;
}

+ (instancetype)alertViewWithTitle:(NSString *)title andMessage:(NSString *)message {
    return [[self alloc] initWithTitle:title andMessage:message];
}

- (instancetype)initWithTitle:(NSString *)title andMessage:(NSString *)message {
    HDAlertView *alertView = [[[self class] alloc] init];
    
    alertView.title = title;
    alertView.message = message;
    alertView.items = [[NSMutableArray alloc] init];
    
    return alertView;
}

- (void)addButtonWithTitle:(NSString *)title type:(HDAlertViewButtonType)type handler:(HDAlertViewHandler)handler {
    HDAlertItem *item = [[HDAlertItem alloc] init];
    
    item.title = title;
    item.type = type;
    item.action = handler;
    [self.items addObject:item];
}

- (void)show {
    if (self.isVisible) return;
    if (self.isAlertAnimating) return;
    
    weakSelf(weakSelf)
    if (self.willShowHandler) {
        self.willShowHandler(weakSelf);
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HDAlertViewWillShowNotification object:self userInfo:nil];
    
    self.visible = YES;
    self.alertAnimating = YES;
    
    [self setupButtons]; // 设置按钮
    [self.alertWindow addSubview:self];
    [self.alertWindow makeKeyAndVisible];
    [self setSubviewsFrame]; // 布局
    
    [self transitionInCompletion:^{
        if (weakSelf.didShowHandler) {
            weakSelf.didShowHandler(weakSelf);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:HDAlertViewDidShowNotification object:weakSelf userInfo:nil];
        
        weakSelf.alertAnimating = NO;
    }];
}

- (void)dismissAnimated:(BOOL)animated {
    [self dismissAnimated:animated cleanup:YES];
}

/**
 *  撤销弹窗提示
 *
 *  @param animated 是否动画
 *  @param cleanup  是否清除
 */
- (void)dismissAnimated:(BOOL)animated cleanup:(BOOL)cleanup {
    BOOL isVisible = self.isVisible;
    
    weakSelf(weakSelf)
    if (self.isVisible) {
        if (self.willDismissHandler) {
            self.willDismissHandler(weakSelf);
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:HDAlertViewWillDismissNotification object:self userInfo:nil];
    }
    
    void (^dismissComplete)(void) = ^{
        weakSelf.visible = NO;
        weakSelf.alertAnimating =  NO;
        
        if (isVisible) {
            if (weakSelf.didDismissHandler) {
                weakSelf.didDismissHandler(weakSelf);
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:HDAlertViewDidDismissNotification object:weakSelf userInfo:nil];
        }
        
        [self removeView];
    };
    
    if (animated && isVisible) {
        self.alertAnimating =  YES;
        [self transitionOutCompletion:dismissComplete];
        
    } else {
        dismissComplete();
    }
}


#pragma mark - Transitions动画
/**
 *  进入的动画
 */
- (void)transitionInCompletion:(void(^)(void))completion {
    switch (self.transitionStyle) {
        case HDAlertViewTransitionStyleFade: {
            self.containerView.alpha = 0;
            
            [UIView animateWithDuration:0.3 animations:^{
                self.containerView.alpha = 1;
            } completion:^(BOOL finished) {
                if (completion) {
                    completion();
                }
            }];
            break;
        }
            
        case HDAlertViewTransitionStyleSlideFromTop: {
            CGRect rect = self.containerView.frame;
            CGRect originalRect = rect;
            rect.origin.y = -rect.size.height;
            self.containerView.frame = rect;
            
            [UIView animateWithDuration:0.3 animations:^{
                self.containerView.frame = originalRect;
            } completion:^(BOOL finished) {
                if (completion) {
                    completion();
                }
            }];
            break;
        }
            
        case HDAlertViewTransitionStyleSlideFromBottom: {
            CGRect rect = self.containerView.frame;
            CGRect originalRect = rect;
            rect.origin.y = self.hd_height;
            self.containerView.frame = rect;
            
            [UIView animateWithDuration:0.3 animations:^{
                self.containerView.frame = originalRect;
            } completion:^(BOOL finished) {
                if (completion) {
                    completion();
                }
            }];
            break;
        }
            
        case HDAlertViewTransitionStyleBounce: {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            animation.values = @[@(0.01), @(1.2), @(0.9), @(1)];
            animation.keyTimes = @[@(0), @(0.4), @(0.6), @(1)];
            animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            animation.duration = 0.5;
            animation.delegate = self;
            [animation setValue:completion forKey:@"handler"];
            [self.containerView.layer addAnimation:animation forKey:@"bouce"];
            break;
        }
            
        case HDAlertViewTransitionStyleDropDown: {
            CGFloat y = self.containerView.center.y;
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
            animation.values = @[@(y - self.bounds.size.height), @(y + 20), @(y - 10), @(y)];
            animation.keyTimes = @[@(0), @(0.5), @(0.75), @(1)];
            animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            animation.duration = 0.4;
            animation.delegate = self;
            [animation setValue:completion forKey:@"handler"];
            [self.containerView.layer addAnimation:animation forKey:@"dropdown"];
            break;
        }
            
        default:
            break;
    }
}

/**
 *  消失的动画
 */
- (void)transitionOutCompletion:(void(^)(void))completion {
    switch (self.transitionStyle) {
        case HDAlertViewTransitionStyleSlideFromBottom: {
            CGRect rect = self.containerView.frame;
            rect.origin.y = self.hd_height;
            
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.containerView.frame = rect;
            } completion:^(BOOL finished) {
                if (completion) {
                    completion();
                }
            }];
            break;
        }
            
        case HDAlertViewTransitionStyleSlideFromTop: {
            CGRect rect = self.containerView.frame;
            rect.origin.y = -rect.size.height;
            
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.containerView.frame = rect;
            } completion:^(BOOL finished) {
                if (completion) {
                    completion();
                }
            }];
            break;
        }
            
        case HDAlertViewTransitionStyleFade: {
            [UIView animateWithDuration:0.25 animations:^{
                self.containerView.alpha = 0;
            } completion:^(BOOL finished) {
                if (completion) {
                    completion();
                }
            }];
            break;
        }
            
        case HDAlertViewTransitionStyleBounce: {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            animation.values = @[@(1), @(1.2), @(0.01)];
            animation.keyTimes = @[@(0), @(0.4), @(1)];
            animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            animation.duration = 0.35;
            animation.delegate = self;
            [animation setValue:completion forKey:@"handler"];
            [self.containerView.layer addAnimation:animation forKey:@"bounce"];
            
            self.containerView.transform = CGAffineTransformMakeScale(0.01, 0.01);
            break;
        }
            
        case HDAlertViewTransitionStyleDropDown: {
            CGPoint point = self.containerView.center;
            point.y += self.hd_height;
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.containerView.center = point;
                CGFloat angle = ((CGFloat)arc4random_uniform(100) - 50.f) / 100.f;
                self.containerView.transform = CGAffineTransformMakeRotation(angle);
            } completion:^(BOOL finished) {
                if (completion) {
                    completion();
                }
            }];
            break;
        }
            
        default:
            break;
    }
}


#pragma mark - 布局
- (void)setSubviewsFrame {
    CGFloat margin = 20.0;
    
    CGFloat horizontalMargin = 25.0;
    // 真机才有效,模拟器统一是25.0
    if ([[NSString hd_deviceType] isEqualToString:iPhone6]) {
        horizontalMargin = 45.0;
    }
    
    if ([[NSString hd_deviceType] isEqualToString:iPhone6Plus]) {
        horizontalMargin = 60.0;
    }
    
    CGFloat containerViewW = (HDMainScreenWidth - horizontalMargin * 2);
    
    /** 标题 */
    CGSize titleLabelSize = {0, 0};
    if (self.title.length > 0) {
        titleLabelSize = [self.title hd_sizeWithSystemFont:self.titleLabel.font constrainedToSize:CGSizeMake(containerViewW, MAXFLOAT)];
    }
    
    CGFloat titleLabelH = titleLabelSize.height;
    CGFloat titleLabelW = containerViewW;
    CGFloat titleLabelX = 0;
    CGFloat titleLabelY = margin;
    self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    /** 消息描述 */
    CGSize messageLabelSize = {0, 0};
    if (self.message.length > 0) {
        messageLabelSize = [self.message hd_sizeWithSystemFont:self.messageLabel.font constrainedToSize:CGSizeMake(containerViewW, MAXFLOAT)];
    }
    
    CGFloat messageLabelH = messageLabelSize.height;
    CGFloat messageLabelW = containerViewW;
    CGFloat messageLabelX = 0;
    CGFloat messageLabelY = CGRectGetMaxY(self.titleLabel.frame) + margin;
    self.messageLabel.frame = CGRectMake(messageLabelX, messageLabelY, messageLabelW, messageLabelH);
    
    /** 按钮 */
    CGFloat buttonH = 44.0;
    CGFloat buttonY = CGRectGetMaxY(self.messageLabel.frame) + margin;
    
    if (self.items.count > 0) {
        
        UIColor *btnColor = HDColor(225, 225, 225);
        if (self.items.count == 2 && self.buttonsListStyle == HDAlertViewButtonsListStyleNormal) {
            CGFloat buttonW = containerViewW * 0.5;
            CGFloat buttonX = 0;
            
            UIButton *button = self.buttons[0];
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            
            button = self.buttons[1];
            button.frame = CGRectMake(buttonW, buttonY, buttonW, buttonH);
            
            UIView *horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(0, buttonY, containerViewW, 1.0)];
            horizontalLine.backgroundColor = btnColor;
            [self.containerView addSubview:horizontalLine];
            
            UIView *verticaleLine = [[UIView alloc] initWithFrame:CGRectMake(buttonW, buttonY, 1.0, buttonH)];
            verticaleLine.backgroundColor = btnColor;
            [self.containerView addSubview:verticaleLine];
            
        } else {
            for (NSUInteger i = 0; i < self.buttons.count; i++) {
                if (i > 0) {
                    buttonY += buttonH;
                }
                
                UIButton *button = self.buttons[i];
                button.frame = CGRectMake(0, buttonY, containerViewW, buttonH);
                
                UIView *horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(0, buttonY, containerViewW, 1.0)];
                horizontalLine.backgroundColor = btnColor;
                [self.containerView addSubview:horizontalLine];
            }
        }
    }
    
    /** 容器视图 */
    CGFloat containerViewH = buttonY + buttonH;
    CGFloat containerViewX = horizontalMargin;
    CGFloat containerViewY = (self.hd_height - containerViewH) * 0.5;
    self.containerView.frame = CGRectMake(containerViewX, containerViewY, containerViewW, containerViewH);
}


#pragma mark - 视图相关
- (void)setUpSubviews {
    /** 容器视图 */
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.layer.cornerRadius = self.cornerRadius;
    containerView.layer.masksToBounds = YES;
    [containerView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPressContainerView:)]];
    [self addSubview:containerView];
    self.containerView = containerView;
    
    /** 标题 */
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = self.titleFont;
    titleLabel.textColor = self.titleColor;
    [self.containerView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    /** 消息描述 */
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.font = self.messageFont;
    messageLabel.textColor = self.messageColor;
    messageLabel.numberOfLines = 0;
    [self.containerView addSubview:messageLabel];
    self.messageLabel = messageLabel;
}

/**
 *  滑动手势处理
 */
- (void)panPressContainerView:(UIPanGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self];
    
    UIButton *btn = [self buttonWithLocation:location];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            if (btn) {
                [self buttonAction:btn];
            }
            break;
        }
            
        default:
            break;
    }
}

/**
 *  遍历手指触摸的点是否在按钮上
 */
- (UIButton *)buttonWithLocation:(CGPoint)location {
    UIButton *btn = nil;
    for (int i = 0; i < self.buttons.count; i++) {
        UIButton *tempBtn = self.buttons[i];
        
        CGRect btnFrame = [tempBtn convertRect:tempBtn.bounds toView:self];
        
        if (CGRectContainsPoint(btnFrame, location)) {
            tempBtn.highlighted = YES;
            btn = tempBtn;
        } else {
            tempBtn.highlighted = NO;
        }
    }
    
    return btn ? btn : nil;
}

/**
 *  懒加载alertWindow
 */
- (HDAlertWindow *)alertWindow {
    if (!_alertWindow) {
        _alertWindow = [[HDAlertWindow alloc] initWithFrame:HDMainScreenBounds andStyle:self.backgroundStyle];
        _alertWindow.alpha = 1.0;
    }
    
    return _alertWindow;
}

/**
 *  设置按钮
 */
- (void)setupButtons {
    self.buttons = [[NSMutableArray alloc] initWithCapacity:self.items.count];
    
    for (NSUInteger i = 0; i < self.items.count; i++) {
        UIButton *button = [self buttonForItemIndex:i];
        [self.buttons addObject:button];
        [self.containerView addSubview:button];
    }
}

- (UIButton *)buttonForItemIndex:(NSUInteger)index {
    HDAlertItem *item = self.items[index];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = index;
    button.titleLabel.font = self.buttonFont;
    button.adjustsImageWhenHighlighted = NO;
    [button setTitle:item.title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage hd_imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage hd_imageWithColor:HDColor(230, 230, 230)] forState:UIControlStateHighlighted];
    
    switch (item.type) {
        case HDAlertViewButtonTypeCancel: {
            [button setTitleColor:self.cancelButtonTitleColor forState:UIControlStateNormal];
            [button setTitleColor:[self.cancelButtonTitleColor colorWithAlphaComponent:0.2] forState:UIControlStateHighlighted];
            break;
        }
            
        case HDAlertViewButtonTypeDestructive: {
            [button setTitleColor:self.destructiveButtonTitleColor forState:UIControlStateNormal];
            [button setTitleColor:[self.destructiveButtonTitleColor colorWithAlphaComponent:0.2] forState:UIControlStateHighlighted];
            break;
        }
            
        case HDAlertViewButtonTypeDefault: {
        default:
            [button setTitleColor:self.defaultButtonTitleColor forState:UIControlStateNormal];
            [button setTitleColor:[self.defaultButtonTitleColor colorWithAlphaComponent:0.2] forState:UIControlStateHighlighted];
            break;
        }
    }
    
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

/**
 *  移除视图
 */
- (void)removeView {
    self.alertWindow.alpha = 0;
    [self.alertWindow removeFromSuperview];
    self.alertWindow = nil;
    [self hd_removeAllSubviews];
    [self removeFromSuperview];
    
    [HDFirstWindow makeKeyAndVisible];
}


#pragma mark - 按钮点击的行动
- (void)buttonAction:(UIButton *)button {
    self.alertAnimating =  YES;
    HDAlertItem *item = self.items[button.tag];
    
    if (item.action) {
        item.action(self);
    }
    
    [self dismissAnimated:YES];
}


#pragma mark - 动画的代理
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    void(^completion)(void) = [anim valueForKeyPath:@"handler"];
    
    if (completion) {
        completion();
    }
}


#pragma mark - setter方法
- (void)setTitle:(NSString *)title {
    if (_title == title) return;
    
    _title = title;
    self.titleLabel.text = title;
}

- (void)setMessage:(NSString *)message {
    if (_message == message) return;
    
    _message = message;
    self.messageLabel.text = message;
}

- (void)setViewBackgroundColor:(UIColor *)viewBackgroundColor {
    if (_viewBackgroundColor == viewBackgroundColor) return;
    
    _viewBackgroundColor = viewBackgroundColor;
    self.containerView.backgroundColor = viewBackgroundColor;
}

- (void)setTitleFont:(UIFont *)titleFont {
    if (_titleFont == titleFont) return;
    
    _titleFont = titleFont;
    self.titleLabel.font = titleFont;
}

- (void)setMessageFont:(UIFont *)messageFont {
    if (_messageFont == messageFont) return;
    
    _messageFont = messageFont;
    self.messageLabel.font = messageFont;
}

- (void)setTitleColor:(UIColor *)titleColor {
    if (_titleColor == titleColor) return;
    
    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}

- (void)setMessageColor:(UIColor *)messageColor {
    if (_messageColor == messageColor) return;
    
    _messageColor = messageColor;
    self.messageLabel.textColor = messageColor;
}

- (void)setButtonFont:(UIFont *)buttonFont {
    if (_buttonFont == buttonFont) return;
    
    _buttonFont = buttonFont;
    for (UIButton *button in self.buttons) {
        button.titleLabel.font = buttonFont;
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    if (_cornerRadius == cornerRadius) return;
    
    _cornerRadius = cornerRadius;
    self.containerView.layer.cornerRadius = cornerRadius;
}

- (void)setDefaultButtonTitleColor:(UIColor *)defaultButtonTitleColor {
    if (_defaultButtonTitleColor == defaultButtonTitleColor) return;
    
    _defaultButtonTitleColor = defaultButtonTitleColor;
    [self setColor:defaultButtonTitleColor toButtonsOfType:HDAlertViewButtonTypeDefault];
}

- (void)setCancelButtonTitleColor:(UIColor *)cancelButtonTitleColor {
    if (_cancelButtonTitleColor == cancelButtonTitleColor) return;
    
    _cancelButtonTitleColor = cancelButtonTitleColor;
    [self setColor:cancelButtonTitleColor toButtonsOfType:HDAlertViewButtonTypeCancel];
}

- (void)setDestructiveButtonTitleColor:(UIColor *)destructiveButtonTitleColor {
    if (_destructiveButtonTitleColor == destructiveButtonTitleColor) return;
    
    _destructiveButtonTitleColor = destructiveButtonTitleColor;
    [self setColor:destructiveButtonTitleColor toButtonsOfType:HDAlertViewButtonTypeDestructive];
}

- (void)setDefaultButtonImage:(UIImage *)defaultButtonImage forState:(UIControlState)state {
    [self setButtonImage:defaultButtonImage forState:state andButtonType:HDAlertViewButtonTypeDefault];
}

- (void)setCancelButtonImage:(UIImage *)cancelButtonImage forState:(UIControlState)state {
    [self setButtonImage:cancelButtonImage forState:state andButtonType:HDAlertViewButtonTypeCancel];
}

- (void)setDestructiveButtonImage:(UIImage *)destructiveButtonImage forState:(UIControlState)state {
    [self setButtonImage:destructiveButtonImage forState:state andButtonType:HDAlertViewButtonTypeDestructive];
}

- (void)setButtonImage:(UIImage *)image forState:(UIControlState)state andButtonType:(HDAlertViewButtonType)type {
    for (NSUInteger i = 0; i < self.items.count; i++) {
        HDAlertItem *item = self.items[i];
        if(item.type == type) {
            UIButton *button = self.buttons[i];
            
            if (state == UIControlStateSelected) {
                state = UIControlStateHighlighted;
            }
            
            [button setBackgroundImage:image forState:state];
        }
    }
}

- (void)setColor:(UIColor *)color toButtonsOfType:(HDAlertViewButtonType)type {
    for (NSUInteger i = 0; i < self.items.count; i++) {
        HDAlertItem *item = self.items[i];
        if(item.type == type) {
            UIButton *button = self.buttons[i];
            [button setTitleColor:color forState:UIControlStateNormal];
            [button setTitleColor:[color colorWithAlphaComponent:0.2] forState:UIControlStateHighlighted];
        }
    }
}

@end

