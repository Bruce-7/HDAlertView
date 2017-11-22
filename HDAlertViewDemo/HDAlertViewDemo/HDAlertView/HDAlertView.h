//
//  HDAlertView.h
//  Seven
//
//  Created by HeDong on 16/9/1.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDMacro.h"

HD_EXTERN NSString *const HDAlertViewWillShowNotification;
HD_EXTERN NSString *const HDAlertViewDidShowNotification;
HD_EXTERN NSString *const HDAlertViewWillDismissNotification;
HD_EXTERN NSString *const HDAlertViewDidDismissNotification;

typedef NS_ENUM(NSInteger, HDAlertViewStyle) {
    HDAlertViewStyleAlert = 0,  // 默认
    HDAlertViewStyleActionSheet
};

typedef NS_ENUM(NSInteger, HDAlertViewButtonType) {
    HDAlertViewButtonTypeDefault = 0,   // 字体默认蓝色
    HDAlertViewButtonTypeDestructive,   // 字体默认红色
    HDAlertViewButtonTypeCancel         // 字体默认绿色
};

typedef NS_ENUM(NSInteger, HDAlertViewBackgroundStyle) {
    HDAlertViewBackgroundStyleSolid = 0,    // 平面的
    HDAlertViewBackgroundStyleGradient      // 聚光的
};

typedef NS_ENUM(NSInteger, HDAlertViewButtonsListStyle) {
    HDAlertViewButtonsListStyleNormal = 0,
    HDAlertViewButtonsListStyleRows // 每个按钮都是一行
};

typedef NS_ENUM(NSInteger, HDAlertViewTransitionStyle) {
    HDAlertViewTransitionStyleFade = 0,             // 渐退
    HDAlertViewTransitionStyleSlideFromTop,         // 从顶部滑入滑出
    HDAlertViewTransitionStyleSlideFromBottom,      // 从底部滑入滑出
    HDAlertViewTransitionStyleBounce,               // 弹窗效果
    HDAlertViewTransitionStyleDropDown              // 顶部滑入底部滑出
};

@class HDAlertView;
typedef void(^HDAlertViewHandler)(HDAlertView *alertView);

@interface HDAlertView : UIView

/** 是否支持旋转 */
@property (nonatomic, assign) BOOL isSupportRotating;

/** 图标的名字 */
@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *title; // ActionSheet模式最多2行
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSTextAlignment titleTextAlignment;
@property (nonatomic, assign) NSTextAlignment messageTextAlignment;


@property (nonatomic, assign) HDAlertViewStyle alertViewStyle;              // 默认是HDAlertViewStyleAlert
@property (nonatomic, assign) HDAlertViewTransitionStyle transitionStyle;   // 默认是 HDAlertViewTransitionStyleFade
@property (nonatomic, assign) HDAlertViewBackgroundStyle backgroundStyle;   // 默认是 HDAlertViewBackgroundStyleSolid
@property (nonatomic, assign) HDAlertViewButtonsListStyle buttonsListStyle; // 默认是 HDAlertViewButtonsListStyleNormal

@property (nonatomic, copy) HDAlertViewHandler willShowHandler;
@property (nonatomic, copy) HDAlertViewHandler didShowHandler;
@property (nonatomic, copy) HDAlertViewHandler willDismissHandler;
@property (nonatomic, copy) HDAlertViewHandler didDismissHandler;

@property (nonatomic, strong) UIColor *viewBackgroundColor          UI_APPEARANCE_SELECTOR; // 默认是clearColor
@property (nonatomic, strong) UIColor *titleColor                   UI_APPEARANCE_SELECTOR; // 默认是blackColor
@property (nonatomic, strong) UIColor *messageColor                 UI_APPEARANCE_SELECTOR; // 默认是darkGrayColor
@property (nonatomic, strong) UIColor *defaultButtonTitleColor      UI_APPEARANCE_SELECTOR; // 默认是blueColor
@property (nonatomic, strong) UIColor *cancelButtonTitleColor       UI_APPEARANCE_SELECTOR; // 默认是greenColor
@property (nonatomic, strong) UIColor *destructiveButtonTitleColor  UI_APPEARANCE_SELECTOR; // 默认是redColor
@property (nonatomic, strong) UIFont *titleFont                     UI_APPEARANCE_SELECTOR; // 默认是bold 18.0
@property (nonatomic, strong) UIFont *messageFont                   UI_APPEARANCE_SELECTOR; // 默认是system 16.0
@property (nonatomic, strong) UIFont *buttonFont                    UI_APPEARANCE_SELECTOR; // 默认是bold buttonFontSize
@property (nonatomic, assign) CGFloat cornerRadius                  UI_APPEARANCE_SELECTOR; // 默认是10.0


/**
 *  设置默认按钮图片和状态
 */
- (void)setDefaultButtonImage:(UIImage *)defaultButtonImage forState:(UIControlState)state  UI_APPEARANCE_SELECTOR;

/**
 *  设置取消按钮图片和状态
 */
- (void)setCancelButtonImage:(UIImage *)cancelButtonImage forState:(UIControlState)state    UI_APPEARANCE_SELECTOR;

/**
 *  设置毁灭性按钮图片和状态
 */
- (void)setDestructiveButtonImage:(UIImage *)destructiveButtonImage forState:(UIControlState)state  UI_APPEARANCE_SELECTOR;

/**
 *  初始化一个弹窗提示
 */
- (instancetype)initWithTitle:(NSString *)title andMessage:(NSString *)message;
+ (instancetype)alertViewWithTitle:(NSString *)title andMessage:(NSString *)message;

/**
 *  添加按钮点击时候和处理
 *
 *  @param title   按钮名字
 *  @param type    按钮类型
 *  @param handler 点击按钮处理事件
 */
- (void)addButtonWithTitle:(NSString *)title type:(HDAlertViewButtonType)type handler:(HDAlertViewHandler)handler;

/**
 *  显示弹窗提示
 */
- (void)show;

/**
 *  移除视图
 */
- (void)removeAlertView;

/**
 快速弹窗
 
 @param title 标题
 @param message 消息体
 @param cancelButtonTitle 取消按钮文字
 @param otherButtonTitles 其他按钮
 @param block 回调
 @return 返回HDAlertView对象
 */
+ (HDAlertView *)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles handler:(void (^)(HDAlertView *alertView, NSInteger buttonIndex))block;

/**
 ActionSheet样式弹窗
 
 @param title 标题
 @return 返回HBAlertView对象
 */
+ (HDAlertView *)showActionSheetWithTitle:(NSString *)title;

@end
