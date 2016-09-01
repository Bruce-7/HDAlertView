//
//  ViewController.m
//  HDAlertViewDemo
//
//  Created by HeDong on 16/9/1.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "ViewController.h"
#import "HDAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)styleOne {
    HDAlertView *alertView = [HDAlertView alertViewWithTitle:@"样式1" andMessage:@"~\(≧▽≦)/~啦啦啦"];
    
    [alertView addButtonWithTitle:@"确定" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
        NSLog(@"styleOne");
    }];
    
    [alertView show];
}

- (IBAction)styleTwo {
    HDAlertView *alertView = [HDAlertView alertViewWithTitle:@"样式2" andMessage:@"~\(≧▽≦)/~啦啦啦"];
    
    [alertView addButtonWithTitle:@"确定" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
        NSLog(@"styleTwo 确定");
    }];
    
    [alertView addButtonWithTitle:@"取消" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
        NSLog(@"styleTwo 取消");
    }];
    
    [alertView show];
}

- (IBAction)styleThree {
    HDAlertView *alertView = [HDAlertView alertViewWithTitle:@"样式3" andMessage:@"~\(≧▽≦)/~啦啦啦"];
    alertView.buttonsListStyle = HDAlertViewButtonsListStyleRows;
    
    [alertView addButtonWithTitle:@"确定" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
        NSLog(@"styleThree 确定");
    }];
    
    [alertView addButtonWithTitle:@"取消" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
        NSLog(@"styleThree 取消");
    }];
    
    [alertView show];
}

- (IBAction)styleFour {
    HDAlertView *alertView = [HDAlertView alertViewWithTitle:@"样式4" andMessage:@"~\(≧▽≦)/~啦啦啦~\(≧▽≦)/~啦啦啦~\(≧▽≦)/~啦啦啦~\(≧▽≦)/~啦啦啦~\(≧▽≦)/~啦啦啦~\(≧▽≦)/~啦啦啦~\(≧▽≦)/~啦啦啦~\(≧▽≦)/~啦啦啦~\(≧▽≦)/~啦啦啦~\(≧▽≦)/~啦啦啦"];
    
    [alertView addButtonWithTitle:@"确定" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
        NSLog(@"styleFour 确定");
    }];
    
    [alertView addButtonWithTitle:@"取消" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
        NSLog(@"styleFour 取消");
    }];
    
    [alertView addButtonWithTitle:@"来呀" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
        NSLog(@"styleFour 来呀");
    }];
    
    [alertView addButtonWithTitle:@"互相" type:HDAlertViewButtonTypeCancel handler:^(HDAlertView *alertView) {
        NSLog(@"styleFour 互相");
    }];
    
    [alertView addButtonWithTitle:@"伤害" type:HDAlertViewButtonTypeDestructive handler:^(HDAlertView *alertView) {
        NSLog(@"styleFour 伤害");
    }];
    
    [alertView show];
}

- (IBAction)styleFive {
    HDAlertView *alertView = [HDAlertView alertViewWithTitle:@"样式5" andMessage:@"其他的自己写着玩吧~~~"];
    alertView.transitionStyle = HDAlertViewTransitionStyleDropDown;
    alertView.backgroundStyle = HDAlertViewBackgroundStyleGradient;
    
    [alertView addButtonWithTitle:@"确定" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
        NSLog(@"styleFive");
    }];
    
    [alertView show];
}

/**
 *  宝宝们, 别乱玩...
 */
- (IBAction)styleSix {
    HDAlertView *alertView = [HDAlertView alertViewWithTitle:@"真的没了" andMessage:@"不骗你, 真的最后一个了"];
    alertView.transitionStyle = HDAlertViewTransitionStyleFade;
    
    [alertView addButtonWithTitle:@"确定" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
        NSLog(@"styleSix 1");
    }];
    
    [alertView show];
    
    
    HDAlertView *alertView1 = [HDAlertView alertViewWithTitle:@"最后一个" andMessage:@"点了就没了"];
    alertView1.transitionStyle = HDAlertViewTransitionStyleSlideFromTop;
    
    [alertView1 addButtonWithTitle:@"确定" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
        NSLog(@"styleSix 2");
    }];
    
    [alertView1 show];
    
    
    HDAlertView *alertView2 = [HDAlertView alertViewWithTitle:@"没有惊喜" andMessage:@"哈哈, 骗你的, 没有惊喜"];
    alertView2.transitionStyle = HDAlertViewTransitionStyleSlideFromBottom;
    
    [alertView2 addButtonWithTitle:@"确定" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
        NSLog(@"styleSix 3");
    }];
    
    [alertView2 show];
    
    
    HDAlertView *alertView3 = [HDAlertView alertViewWithTitle:@"惊喜往往在后面" andMessage:@"再次点击就告诉你"];
    alertView3.transitionStyle = HDAlertViewTransitionStyleBounce;
    alertView3.backgroundStyle = HDAlertViewBackgroundStyleGradient;
    
    [alertView3 addButtonWithTitle:@"确定" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
        NSLog(@"styleSix 4");
    }];
    
    [alertView3 show];
    
    
    HDAlertView *alertView4 = [HDAlertView alertViewWithTitle:@"有个秘密告诉你" andMessage:@"确定之后会有意外惊喜"];
    alertView4.transitionStyle = HDAlertViewTransitionStyleDropDown;
    alertView4.backgroundStyle = HDAlertViewBackgroundStyleGradient;
    
    [alertView4 addButtonWithTitle:@"确定" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
        NSLog(@"styleSix 5");
    }];
    
    [alertView4 show];
}

@end
