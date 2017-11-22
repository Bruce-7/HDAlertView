//
//  UIView+HDExtension.m
//  PortableTreasure
//
//  Created by HeDong on 14/12/1.
//  Copyright © 2014年 hedong. All rights reserved.
//

#import "UIView+HDExtension.h"

@implementation UIView (HDExtension)

#pragma mark - 快速设置控件的frame
- (void)setHd_x:(CGFloat)hd_x {
    CGRect frame = self.frame;
    frame.origin.x = hd_x;
    self.frame = frame;
}

- (CGFloat)hd_x {
    return self.frame.origin.x;
}

- (void)setHd_y:(CGFloat)hd_y {
    CGRect frame = self.frame;
    frame.origin.y = hd_y;
    self.frame = frame;
}

- (CGFloat)hd_y {
    return self.frame.origin.y;
}

- (void)setHd_centerX:(CGFloat)hd_centerX {
    CGPoint center = self.center;
    center.x = hd_centerX;
    self.center = center;
}

- (CGFloat)hd_centerX {
    return self.center.x;
}

- (void)setHd_centerY:(CGFloat)hd_centerY {
    CGPoint center = self.center;
    center.y = hd_centerY;
    self.center = center;
}

- (CGFloat)hd_centerY {
    return self.center.y;
}

- (void)setHd_width:(CGFloat)hd_width {
    CGRect frame = self.frame;
    frame.size.width = hd_width;
    self.frame = frame;
}

- (CGFloat)hd_width {
    return self.frame.size.width;
}

- (void)setHd_height:(CGFloat)hd_height {
    CGRect frame = self.frame;
    frame.size.height = hd_height;
    self.frame = frame;
}

- (CGFloat)hd_height {
    return self.frame.size.height;
}

- (void)setHd_size:(CGSize)hd_size {
    CGRect frame = self.frame;
    frame.size = hd_size;
    self.frame = frame;
}

- (CGSize)hd_size {
    return self.frame.size;
}

- (void)setHd_origin:(CGPoint)hd_origin {
    CGRect frame = self.frame;
    frame.origin = hd_origin;
    self.frame = frame;
}

- (CGPoint)hd_origin {
    return self.frame.origin;
}

- (void)setHb_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)hb_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setHb_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)hb_bottom {
    return self.frame.origin.y + self.frame.size.height;
}


#pragma mark - 视图相关
- (void)hd_removeAllSubviews {
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}


#pragma mark - 动画相关
- (instancetype)hd_addAnimationAtPoint:(CGPoint)point; {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGFloat diameter = [self hd_mdShapeDiameterForPoint:point];
    shapeLayer.frame = CGRectMake(floor(point.x - diameter * 0.5), floor(point.y - diameter * 0.5), diameter, diameter);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0, 0.0, diameter, diameter)].CGPath;
    [self.layer addSublayer:shapeLayer];
    shapeLayer.fillColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0].CGColor;
    // animate
    CGFloat scale = 100.0 / shapeLayer.frame.size.width;
    NSString *timingFunctionName = kCAMediaTimingFunctionDefault; //inflating ? kCAMediaTimingFunctionDefault : kCAMediaTimingFunctionDefault;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunctionName];
    animation.removedOnCompletion = YES;
    animation.duration = 3.0;
    shapeLayer.transform = [animation.toValue CATransform3DValue];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [shapeLayer removeFromSuperlayer];
    }];
    [shapeLayer addAnimation:animation forKey:@"shapeBackgroundAnimation"];
    [CATransaction commit];
    
    return self;
}

- (instancetype)hd_addAnimationAtPoint:(CGPoint)point WithType:(HDAnimationType)type withColor:(UIColor *)animationColor completion:(void (^)(BOOL))completion {
    [self hd_addAnimationAtPoint:point WithDuration:1.0 WithType:type withColor:animationColor  completion:completion];
    
    return self;
}

- (instancetype)hd_addAnimationAtPoint:(CGPoint)point WithDuration:(NSTimeInterval)duration WithType:(HDAnimationType)type withColor:(UIColor *)animationColor completion:(void (^)(BOOL finished))completion {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGFloat diameter = [self hd_mdShapeDiameterForPoint:point];
    shapeLayer.frame = CGRectMake(floor(point.x - diameter * 0.5), floor(point.y - diameter * 0.5), diameter, diameter);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0, 0.0, diameter, diameter)].CGPath;
    
    shapeLayer.fillColor = animationColor.CGColor;
    // animate
    CGFloat scale = 1.0 / shapeLayer.frame.size.width;
    NSString *timingFunctionName = kCAMediaTimingFunctionDefault; //inflating ? kCAMediaTimingFunctionDefault : kCAMediaTimingFunctionDefault;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    switch (type) {
        case HDAnimationOpen:
        {
            [self.layer addSublayer:shapeLayer];
            animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
            animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
            break;
        }
        case HDAnimationClose:
        {
            [self.layer insertSublayer:shapeLayer atIndex:0];
            animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
            animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
            break;
        }
        default:
            break;
    }
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunctionName];
    animation.removedOnCompletion = YES;
    animation.duration = duration;
    shapeLayer.transform = [animation.toValue CATransform3DValue];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [shapeLayer removeFromSuperlayer];
        completion(true);
    }];
    [shapeLayer addAnimation:animation forKey:@"shapeBackgroundAnimation"];
    [CATransaction commit];
    
    return self;
}

- (instancetype)hd_addAnimationAtPoint:(CGPoint)point WithType:(HDAnimationType)type withColor:(UIColor *)animationColor; {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGFloat diameter = [self hd_mdShapeDiameterForPoint:point];
    shapeLayer.frame = CGRectMake(floor(point.x - diameter * 0.5), floor(point.y - diameter * 0.5), diameter, diameter);
    shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0, 0.0, diameter, diameter)].CGPath;
    
    shapeLayer.fillColor = animationColor.CGColor;
    // animate
    CGFloat scale = 100.0 / shapeLayer.frame.size.width;
    NSString *timingFunctionName = kCAMediaTimingFunctionDefault; //inflating ? kCAMediaTimingFunctionDefault : kCAMediaTimingFunctionDefault;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    switch (type) {
        case HDAnimationOpen:
        {
            [self.layer addSublayer:shapeLayer];
            animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
            animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
            break;
        }
        case HDAnimationClose:
        {
            [self.layer insertSublayer:shapeLayer atIndex:0];
            animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1.0)];
            animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
            break;
        }
        default:
            break;
    }
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunctionName];
    animation.removedOnCompletion = YES;
    animation.duration = 3.0;
    shapeLayer.transform = [animation.toValue CATransform3DValue];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [shapeLayer removeFromSuperlayer];
    }];
    [shapeLayer addAnimation:animation forKey:@"shapeBackgroundAnimation"];
    [CATransaction commit];
    
    return self;
}

// 计算离屏幕的边框最大的距离
- (CGFloat)hd_mdShapeDiameterForPoint:(CGPoint)point {
    CGPoint cornerPoints[] = {
        {0.0, 0.0},
        {0.0, self.bounds.size.height},
        {self.bounds.size.width, self.bounds.size.height},
        {self.bounds.size.width, 0.0}
    };
    
    CGFloat radius = 0.0;
    for (int i = 0; i < 4; i++) {
        CGPoint p = cornerPoints[i];
        CGFloat d = sqrt( pow(p.x - point.x, 2.0) + pow(p.y - point.y, 2.0));
        if (d > radius) {
            radius = d;
        }
    }
    
    return radius * 2.0;
}


#pragma UIView变成UIImage
#pragma UIView变成UIImage
+ (UIImage *)hd_convertViewToImage:(UIView *)view {
    // 第二个参数表示是否非透明。如果需要显示半透明效果，需传NO，否则YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)hd_snapsHotView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)hd_convertViewToImage {
    return [UIView hd_convertViewToImage:self];
}

- (UIImage *)hd_snapsHotView {
    return [UIView hd_snapsHotView:self];
}

@end
