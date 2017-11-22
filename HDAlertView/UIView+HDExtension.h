//
//  UIView+HDExtension.h
//  PortableTreasure
//
//  Created by HeDong on 14/12/1.
//  Copyright © 2014年 hedong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HDAnimationType) {
    HDAnimationOpen, // 动画开启
    HDAnimationClose // 动画关闭
};

@interface UIView (HDExtension)


#pragma mark - 快速设置控件的frame
@property (nonatomic, assign) CGFloat hd_x;
@property (nonatomic, assign) CGFloat hd_y;
@property (nonatomic, assign) CGFloat hd_centerX;
@property (nonatomic, assign) CGFloat hd_centerY;
@property (nonatomic, assign) CGFloat hd_width;
@property (nonatomic, assign) CGFloat hd_height;
@property (nonatomic, assign) CGPoint hd_origin;
@property (nonatomic, assign) CGSize  hd_size;
@property (nonatomic, assign) CGFloat hb_right;
@property (nonatomic, assign) CGFloat hb_bottom;


#pragma mark - 视图相关
/**
 *  移除全部的子视图
 */
- (void)hd_removeAllSubviews;

#pragma mark - 动画相关
/**
 *  在某个点添加动画
 *
 *  @param point 动画开始的点
 */
- (instancetype)hd_addAnimationAtPoint:(CGPoint)point;

/**
 *  在某个点添加动画
 *
 *  @param point 动画开始的点
 *  @param type  动画的类型
 *  @param color 动画的颜色
 */
- (instancetype)hd_addAnimationAtPoint:(CGPoint)point WithType:(HDAnimationType)type withColor:(UIColor *)animationColor;

/**
 *  在某个点添加动画
 *
 *  @param point 动画开始的点
 *  @param type  动画的类型
 *  @param color 动画的颜色
 *  @param completion 动画结束后的代码快
 */
- (instancetype)hd_addAnimationAtPoint:(CGPoint)point WithType:(HDAnimationType)type withColor:(UIColor *)animationColor completion:(void (^)(BOOL finished))completion;

/**
 *  在某个点添加动画
 *
 *  @param point      动画开始的点
 *  @param duration   动画时间
 *  @param type       动画的类型
 *  @param color 动画的颜色
 *  @param completion 动画结束后的代码快
 */
- (instancetype)hd_addAnimationAtPoint:(CGPoint)point WithDuration:(NSTimeInterval)duration WithType:(HDAnimationType) type withColor:(UIColor *)animationColor completion:(void (^)(BOOL finished))completion;


#pragma UIView变成UIImage
/**
 视图转成图片
 
 @return 返回图片
 */
- (UIImage *)hd_convertViewToImage;

/**
 视图裁剪成图片
 
 @return 返回图片
 */
- (UIImage *)hd_snapsHotView;

/**
 视图转成图片
 
 @param view 视图
 @return 返回图片
 */
+ (UIImage *)hd_convertViewToImage:(UIView *)view;

/**
 视图裁剪成图片
 
 @param view 视图
 @return 返回图片
 */
+ (UIImage *)hd_snapsHotView:(UIView *)view;

@end
