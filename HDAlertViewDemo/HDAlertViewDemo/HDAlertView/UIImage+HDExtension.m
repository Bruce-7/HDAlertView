//
//  UIImage+HDExtension.m
//  PortableTreasure
//
//  Created by HeDong on 15/1/17.
//  Copyright © 2015年 hedong. All rights reserved.
//

#import "UIImage+HDExtension.h"
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (HDExtension)

+ (instancetype)hd_resizedImageWithImageName:(NSString *)name {
    return [self hd_resizedImageWithImage:[UIImage imageNamed:name]];
}

+ (instancetype)hd_resizedImageWithImage:(UIImage *)image {
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+ (instancetype)hd_cutImage:(UIImage*)image andSize:(CGSize)newImageSize {
    UIGraphicsBeginImageContextWithOptions(newImageSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newImageSize.width, newImageSize.height)];
    // 从上下文中取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (instancetype)hd_captureCircleImage:(UIImage *)image {
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    imageW = MIN(imageH, imageW);
    imageH = imageW;
    
    CGFloat border = imageW / 100 * 2;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    CGFloat radius = imageSize.width * 0.5;
    
    CGSize graphicSize = CGSizeMake(imageSize.width + 2 * border, imageSize.height + 2 * border);
    UIGraphicsBeginImageContextWithOptions(graphicSize, NO, 0.0);
    
    // 灰色边框
    [[UIColor darkGrayColor] setFill];
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextAddArc(context,graphicSize.width * 0.5, graphicSize.height * 0.5, radius+border, -M_PI, M_PI, 0);
    CGContextFillPath(context);
    
    // 红色边框
    [[UIColor colorWithRed:247 / 255.0 green:98 / 255.0 blue:46 / 255.0 alpha:1.0] setFill];
    CGContextAddArc(context, graphicSize.width * 0.5, graphicSize.height * 0.5, radius + border, -M_PI * 1.35, M_PI * 0.35, 1);
    CGContextFillPath(context);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(graphicSize.width * 0.5, graphicSize.height * 0.5) radius:radius startAngle:-M_PI endAngle:M_PI clockwise:YES];
    [path addClip];

    CGRect imageFrame = CGRectMake(border, border, imageSize.width, imageSize.height);
    [image drawInRect:imageFrame];
    UIImage *finishImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return finishImage;
}

+ (instancetype)hd_captureCircleImageWithURL:(NSString *)iconUrl andBorderWith:(CGFloat)border andBorderColor:(UIColor *)color {
    return [self hd_captureCircleImageWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:iconUrl]]] andBorderWith:border andBorderColor:color];
}

+ (instancetype)hd_captureCircleImageWithImage:(UIImage *)iconImage andBorderWith:(CGFloat)border andBorderColor:(UIColor *)color {
    CGFloat imageW = iconImage.size.width + border * 2;
    CGFloat imageH = iconImage.size.height + border * 2;
    imageW = MIN(imageH, imageW);
    imageH = imageW;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    // 新建一个图形上下文
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [color set];
    // 画大圆
    CGFloat bigRadius = imageW * 0.5;
    CGFloat centerX = imageW * 0.5;
    CGFloat centerY = imageH * 0.5;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx);
    // 画小圆
    CGFloat smallRadius = bigRadius - border;
    CGContextAddArc(ctx , centerX , centerY , smallRadius ,0, M_PI * 2, 0);
    // 切割
    CGContextClip(ctx);
    // 画图片
    [iconImage drawInRect:CGRectMake(border, border, iconImage.size.width, iconImage.size.height)];
    //从上下文中取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (instancetype)hd_blurredImageWithImage:(UIImage *)image andBlurAmount:(CGFloat)blurAmount {
    return [image hd_blurredImage:blurAmount];
}

+ (instancetype)hd_viewShotWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (instancetype)hd_screenShot {
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen]) {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            CGContextConcatCTM(context, [window transform]);
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            [[window layer] renderInContext:context];
            
            CGContextRestoreGState(context);
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)hd_waterImageWithBgImageName:(NSString *)bgName andWaterImageName:(NSString *)waterImageName {
    UIImage *bgImage = [UIImage imageNamed:bgName];
    CGSize imageViewSize = bgImage.size;
    
    UIGraphicsBeginImageContextWithOptions(imageViewSize, NO, 0.0);
    [bgImage drawInRect:CGRectMake(0, 0, imageViewSize.width, imageViewSize.height)];
    
    UIImage *waterImage = [UIImage imageNamed:waterImageName];
    CGFloat scale = 0.2;
    CGFloat margin = 5;
    CGFloat waterW = imageViewSize.width * scale;
    CGFloat waterH = imageViewSize.height * scale;
    CGFloat waterX = imageViewSize.width - waterW - margin;
    CGFloat waterY = imageViewSize.height - waterH - margin;
    
    [waterImage drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (instancetype)hd_reduceImage:(UIImage *)image percent:(CGFloat)percent {
    NSData *imageData = UIImageJPEGRepresentation(image, percent);
    UIImage *newImage = [UIImage imageWithData:imageData];
    
    return newImage;
}

+ (instancetype)hd_imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (instancetype)hd_imageWithDataSimple:(NSData *)imageData scaledToSize:(CGSize)newSize {
    return [self hd_imageWithImageSimple:[UIImage imageWithData:imageData] scaledToSize:newSize];
}

- (instancetype)hd_blurredImage:(CGFloat)blurAmount {
    if (blurAmount < 0.0 || blurAmount > 2.0) {
        blurAmount = 0.5;
    }
    
    CGImageRef img = self.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    int boxSize = blurAmount * 40;
    boxSize = boxSize - (boxSize % 2) + 1;
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (!error)
    {
        error = vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef);
    
    return returnImage;
}

- (instancetype)hd_blearImageWithBlurLevel:(CGFloat)blurLevel {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:self];
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setDefaults];
    [blurFilter setValue:inputImage forKey:@"inputImage"];
    // 设值模糊的级别
    [blurFilter setValue:[NSNumber numberWithFloat:blurLevel] forKey:@"inputRadius"];
    CIImage *outputImage = [blurFilter valueForKey:@"outputImage"];
    CGRect rect = inputImage.extent; // Create Rect
    // 设值一下减到图片的白边
    rect.origin.x += blurLevel;
    rect.origin.y += blurLevel;
    rect.size.height -= blurLevel * 2.0f;
    rect.size.width -= blurLevel * 2.0f;
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:rect];
    // 获取新的图片
    UIImage *newImage = [UIImage imageWithCGImage:cgImage scale:0.5 orientation:self.imageOrientation];
    // 释放图片
    CGImageRelease(cgImage);
    
    return newImage;
}

+ (instancetype)hd_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end
