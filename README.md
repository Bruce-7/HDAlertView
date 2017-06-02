# HDAlertView

HDAlertView是一个类似系统, 微信, QQ, 等等App的alertView弹窗.
### Demo【演示】
![演示](https://github.com/Bruce-7/HDAlertView/blob/master/Images/HDAlertViewDemo.gif)

### Examples【示例】

```
 HDAlertView *alertView = [HDAlertView alertViewWithTitle:@"HDAlertView" andMessage:@"similar system UIAlertView"];

 [alertView addButtonWithTitle:@"ok" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
     NSLog(@"ok");
 }];

 [alertView addButtonWithTitle:@"cancel" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
     NSLog(@"cancel");
 }];

 [alertView show];

```


### CocoaPods

推荐使用CocoaPods安装

platform :ios, '7.0'

target :'your project' do

pod 'HDAlertView'

end

Pod install

### Manually【手动导入】
1. 通过 Clone or download 下载 HDAlertView 文件夹内的所有内容.
2. 将 HDAlertView 内的源文件添加(拖放)到你的工程.
3. 导入#import "HDAlertView.h".

### 补充
系统自带UIAlertView有常见BUG, 比如和系统键盘动画冲突等等, 需要代理操作等诸多不方便使用. 使用UIAlertController就不会有UIAlertView等等问题, 但是又不支持iOS7.所以才自定义一个类似系统的UIAlertView, 用法和UIAlertController相似, 而且简单.

##### 如果在使用过程中遇到BUG, 希望你能Issues我. 如果对你有所帮助请Star
##### Sina : [@小七柒_7](http://weibo.com/5671953891)

## License

HDAlertView is released under the MIT license. See LICENSE for details.

