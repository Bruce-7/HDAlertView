//
//  UIImage+HDExtension.h
//  PortableTreasure
//
//  Created by HeDong on 15/1/17.
//  Copyright © 2015年 hedong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HDExtension)

/**
 *  拉伸图片
 *
 *  @param name 图片名字
 *
 *  @return 拉伸好的图片
 */
+ (instancetype)hd_resizedImageWithImageName:(NSString *)name;

/**
 *  拉伸图片
 *
 *  @param image 要拉伸的图片
 *
 *  @return 拉伸好的图片
 */
+ (instancetype)hd_resizedImageWithImage:(UIImage *)image;

/**
 *  返回一个缩放好的图片
 *
 *  @param image  要切割的图片
 *  @param imageSize 边框的宽度
 *
 *  @return 切割好的图片
 */
+ (instancetype)hd_cutImage:(UIImage*)image andSize:(CGSize)imageSize;

/**
 *  返回一个下边有半个红圈的原型头像
 *
 *  @param image  要切割的图片
 *
 *  @return 切割好的头像
 */
+ (instancetype)hd_captureCircleImage:(UIImage*)image;

/**
 *  根据url返回一个圆形的头像
 *
 *  @param iconUrl 头像的URL
 *  @param border  边框的宽度
 *  @param color   边框的颜色
 *
 *  @return 切割好的头像
 */
+ (instancetype)hd_captureCircleImageWithURL:(NSString *)iconUrl andBorderWith:(CGFloat)border andBorderColor:(UIColor *)color;

/**
 *  根据iamge返回一个圆形的头像
 *
 *  @param iconImage 要切割的头像
 *  @param border    边框的宽度
 *  @param color     边框的颜色
 *
 *  @return 切割好的头像
 */
+ (instancetype)hd_captureCircleImageWithImage:(UIImage *)iconImage andBorderWith:(CGFloat)border andBorderColor:(UIColor *)color;

/**
 *  生成毛玻璃效果的图片
 *
 *  @param image      要模糊化的图片
 *  @param blurAmount 模糊化指数
 *
 *  @return 返回模糊化之后的图片
 */
+ (instancetype)hd_blurredImageWithImage:(UIImage *)image andBlurAmount:(CGFloat)blurAmount;

/**
 *  截取对应的view生成一张图片
 *
 *  @param view 要截的view
 *
 *  @return 生成的图片
 */
+ (instancetype)hd_viewShotWithView:(UIView *)view;

/**
 *  截屏
 *
 *  @return 返回截屏的图片
 */
+ (instancetype)hd_screenShot;

/**
 *  给图片添加水印
 *
 *  @param bgName         原图的名字
 *  @param waterImageName 水印的名字
 *
 *  @return 添加完水印的图片
 */
+ (instancetype)hd_waterImageWithBgImageName:(NSString *)bgName andWaterImageName:(NSString *)waterImageName ;

/**
 *  图片进行压缩
 *
 *  @param image   要压缩的图片
 *  @param percent 要压缩的比例(建议在0.3以上)
 *
 *  @return 压缩之后的图片
 *
 *  @exception 压缩之后为image/jpeg 格式
 */
+ (instancetype)hd_reduceImage:(UIImage *)image percent:(CGFloat)percent;

/**
 *  对图片进行压缩
 *
 *  @param image   要压缩的图片
 *  @param newSize 压缩后的图片的像素尺寸
 *
 *  @return 压缩好的图片
 */
+ (instancetype)hd_imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize;

/**
 *  对图片进行压缩
 *
 *  @param image   要压缩的图片
 *  @param newSize 压缩后的图片的像素尺寸
 *
 *  @return 压缩好的图片
 */
+ (instancetype)hd_imageWithDataSimple:(NSData *)imageData scaledToSize:(CGSize)newSize;

/**
 *  生成了一个毛玻璃效果的图片
 *
 *  @return 返回模糊化好的图片
 */
- (instancetype)hd_blurredImage:(CGFloat)blurAmount;

/**
 *  生成一个毛玻璃效果的图片
 *
 *  @param blurLevel 毛玻璃的模糊程度
 *
 *  @return 毛玻璃好的图片
 */
- (instancetype)hd_blearImageWithBlurLevel:(CGFloat)blurLevel;

/**
 *  根据颜色返回图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (instancetype)hd_imageWithColor:(UIColor *)color;

@end
