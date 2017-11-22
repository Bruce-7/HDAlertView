//
//  NSString+HDExtension.h
//  PortableTreasure
//
//  Created by HeDong on 15/5/10.
//  Copyright © 2015年 hedong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDMacro.h"

@interface NSString (HDExtension)

#pragma mark - 散列函数
/**
 *  计算MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  md5 -s "string"
 *  @endcode
 *
 *  <p>提示：随着 MD5 碰撞生成器的出现，MD5 算法不应被用于任何软件完整性检查或代码签名的用途。<p>
 *
 *  @return 32个字符的MD5散列字符串
 */
- (instancetype)hd_md5String;

/**
 *  计算SHA1散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha1
 *  @endcode
 *
 *  @return 40个字符的SHA1散列字符串
 */
- (instancetype)hd_sha1String;

/**
 *  计算SHA224散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha224
 *  @endcode
 *
 *  @return 56个字符的SHA224散列字符串
 */
- (instancetype)hd_sha224String;

/**
 *  计算SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha256
 *  @endcode
 *
 *  @return 64个字符的SHA256散列字符串
 */
- (instancetype)hd_sha256String;

/**
 *  计算SHA 384散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha384
 *  @endcode
 *
 *  @return 96个字符的SHA 384散列字符串
 */
- (instancetype)hd_sha384String;

/**
 *  计算SHA 512散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha512
 *  @endcode
 *
 *  @return 128个字符的SHA 512散列字符串
 */
- (instancetype)hd_sha512String;

#pragma mark - HMAC 散列函数
/**
 *  计算HMAC MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl dgst -md5 -hmac "key"
 *  @endcode
 *
 *  @return 32个字符的HMAC MD5散列字符串
 */
- (instancetype)hd_hmacMD5StringWithKey:(NSString *)key;

/**
 *  计算HMAC SHA1散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha1 -hmac "key"
 *  @endcode
 *
 *  @return 40个字符的HMAC SHA1散列字符串
 */
- (instancetype)hd_hmacSHA1StringWithKey:(NSString *)key;

/**
 *  计算HMAC SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha256 -hmac "key"
 *  @endcode
 *
 *  @return 64个字符的HMAC SHA256散列字符串
 */
- (instancetype)hd_hmacSHA256StringWithKey:(NSString *)key;

/**
 *  计算HMAC SHA512散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha512 -hmac "key"
 *  @endcode
 *
 *  @return 128个字符的HMAC SHA512散列字符串
 */
- (instancetype)hd_hmacSHA512StringWithKey:(NSString *)key;

#pragma mark - 文件散列函数
/**
 *  计算文件的MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  md5 file.dat
 *  @endcode
 *
 *  @return 32个字符的MD5散列字符串
 */
- (instancetype)hd_fileMD5Hash;

/**
 *  计算文件的SHA1散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha1 file.dat
 *  @endcode
 *
 *  @return 40个字符的SHA1散列字符串
 */
- (instancetype)hd_fileSHA1Hash;

/**
 *  计算文件的SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha256 file.dat
 *  @endcode
 *
 *  @return 64个字符的SHA256散列字符串
 */
- (instancetype)hd_fileSHA256Hash;

/**
 *  计算文件的SHA512散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha512 file.dat
 *  @endcode
 *
 *  @return 128个字符的SHA512散列字符串
 */
- (instancetype)hd_fileSHA512Hash;

#pragma mark - Base64编码
/**
 *  返回Base64遍码后的字符串
 */
- (instancetype)hd_base64Encode;

/**
 *  返回Base64解码后的字符串
 */
- (instancetype)hd_base64Decode;

#pragma mark - 路径方法
/**
 *  快速返回沙盒中，Documents文件的路径
 *
 *  @return Documents文件的路径
 */
+ (instancetype)hd_pathForDocuments;

/**
 *  快速返回沙盒中，Documents文件中某个子文件的路径
 *
 *  @param fileName 子文件名称
 *
 *  @return 快速返回Documents文件中某个子文件的路径
 */
+ (instancetype)hd_filePathAtDocumentsWithFileName:(NSString *)fileName;

/**
 *  快速返回沙盒中，Library下Caches文件的路径
 *
 *  @return 快速返回沙盒中Library下Caches文件的路径
 */
+ (instancetype)hd_pathForCaches;

/**
 *  快速返回沙盒中，Library下Caches文件中某个子文件的路径
 *
 *  @param fileName 子文件名称
 *
 *  @return 快速返回Caches文件中某个子文件的路径
 */
+ (instancetype)hd_filePathAtCachesWithFileName:(NSString *)fileName;

/**
 *  快速返回沙盒中，MainBundle(资源捆绑包的)的路径
 *
 *  @return 快速返回MainBundle(资源捆绑包的)的路径
 */
+ (instancetype)hd_pathForMainBundle;

/**
 *  快速返回沙盒中，MainBundle(资源捆绑包的)中某个子文件的路径
 *
 *  @param fileName 子文件名称
 *
 *  @return 快速返回MainBundle(资源捆绑包的)中某个子文件的路径
 */
+ (instancetype)hd_filePathAtMainBundleWithFileName:(NSString *)fileName;

/**
 *  快速返回沙盒中，tmp(临时文件)文件的路径
 *
 *  @return 快速返回沙盒中tmp文件的路径
 */
+ (instancetype)hd_pathForTemp;

/**
 *  快速返回沙盒中，temp文件中某个子文件的路径
 *
 *  @param fileName 子文件名
 *
 *  @return 快速返回temp文件中某个子文件的路径
 */
+ (instancetype)hd_filePathAtTempWithFileName:(NSString *)fileName;

/**
 *  快速返回沙盒中，Library下Preferences文件的路径
 *
 *  @return 快速返回沙盒中Library下Caches文件的路径
 */
+ (instancetype)hd_pathForPreferences;

/**
 *  快速返回沙盒中，Library下Preferences文件中某个子文件的路径
 *
 *  @param fileName 子文件名称
 *
 *  @return 快速返回Preferences文件中某个子文件的路径
 */
+ (instancetype)hd_filePathAtPreferencesWithFileName:(NSString *)fileName;

/**
 *  快速返回沙盒中，你指定的系统文件的路径。tmp文件除外，tmp用系统的NSTemporaryDirectory()函数更加便捷
 *
 *  @param directory NSSearchPathDirectory枚举
 *
 *  @return 快速你指定的系统文件的路径
 */
+ (instancetype)hd_pathForSystemFile:(NSSearchPathDirectory)directory;

/**
 *  快速返回沙盒中，你指定的系统文件的中某个子文件的路径。tmp文件除外，请使用filePathAtTempWithFileName
 *
 *  @param directory 你指的的系统文件
 *  @param fileName  子文件名
 *
 *  @return 快速返回沙盒中，你指定的系统文件的中某个子文件的路径
 */
+ (instancetype)hd_filePathForSystemFile:(NSSearchPathDirectory)directory withFileName:(NSString *)fileName;

#pragma mark - 文本计算方法
/**
 *  计算文字大小
 *
 *  @param font 字体
 *  @param size 计算范围的大小
 *  @param mode 段落样式
 *
 *  @return 计算出来的大小
 */
- (CGSize)hd_sizeWithSystemFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode;

/**
 计算字符串高度
 
 @param font 字体
 @param size 限制大小
 @param mode 计算的换行模型
 @param numberOfLine 限制计算高度的行数
 @return 返回计算大小
 */
- (CGSize)hd_sizeWithSystemFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode numberOfLine:(NSInteger)numberOfLine;

/**
 *  计算文字大小
 *
 *  @param font 字体
 *  @param size 计算范围的大小
 *
 *  @return 计算出来的大小
 */
- (CGSize)hd_sizeWithSystemFont:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 *  计算文字大小
 *
 *  @param text 文字
 *  @param font 字体
 *  @param size 计算范围的大小
 *
 *  @return 计算出来的大小
 */
+ (CGSize)hd_sizeWithText:(NSString *)text systemFont:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 计算粗体文字大小

 @param font 字体
 @param size 计算范围的大小
 @param mode 计算的换行模型
 @return 计算出来的大小
 */
- (CGSize)hd_sizeWithBoldFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode;

/**
 计算粗体文字大小

 @param font 字体
 @param size 计算范围的大小
 @return 计算出来的大小
 */
- (CGSize)hd_sizeWithBoldFont:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 计算粗体文字大小

 @param font 字体
 @param size 计算范围的大小
 @param mode 计算的换行模型
 @param numberOfLine 限制计算高度的行数
 @return 计算出来的大小
 */
- (CGSize)hd_sizeWithBoldFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode numberOfLine:(NSInteger)numberOfLine;


#pragma mark - 富文本相关
/**
 转变成富文本
 
 @param lineSpacing 行间距
 @param kern 文字间的间距
 @param lineBreakMode 换行方式
 @param alignment 文字对齐格式
 @return 转变后的富文本
 */
- (NSAttributedString *)hd_conversionToAttributedStringWithLineSpeace:(CGFloat)lineSpacing kern:(CGFloat)kern lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment;

/**
 计算富文本字体大小
 
 @param lineSpeace 行间距
 @param kern 文字间的间距
 @param font 字体
 @param size 计算范围
 @param lineBreakMode 换行方式
 @param alignment 文字对齐格式
 @return 计算后的字体大小
 */
- (CGSize)hd_sizeWithAttributedStringLineSpeace:(CGFloat)lineSpeace kern:(CGFloat)kern font:(UIFont *)font size:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment;

/**
 计算富文本字体大小
 
 @param lineSpeace 行间距
 @param kern 文字间的间距
 @param font 字体
 @param size 计算范围
 @param lineBreakMode 换行方式
 @param alignment 文字对齐格式
 @param numberOfLine 限制计算行数
 @return 计算后的字体大小
 */
- (CGSize)hd_sizeWithAttributedStringLineSpeace:(CGFloat)lineSpeace kern:(CGFloat)kern font:(UIFont *)font size:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment numberOfLine:(NSInteger)numberOfLine;

/**
 是否是一行高度
 
 @param lineSpeace 行间距
 @param kern 文字间的间距
 @param font 字体
 @param size 计算范围
 @param lineBreakMode 换行方式
 @param alignment 文字对齐格式
 @return 返回YES代表1行, NO代表多行
 */
- (BOOL)hd_numberOfLineWithLineSpeace:(CGFloat)lineSpeace kern:(CGFloat)kern font:(UIFont *)font size:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment;

#pragma mark - 设备相关
/**
 *  设备版本
 */
+ (instancetype)hd_deviceVersion;

/**
 *  设备类型(用于区分iPhone屏幕大小)
 */
HD_EXTERN NSString *const iPhone6_6s_7_8;
HD_EXTERN NSString *const iPhone6_6s_7_8Plus;
HD_EXTERN NSString *const iPhone_X;
+ (instancetype)hd_deviceType;


#pragma mark - 效验相关
/**
 *  判断是否是邮箱
 */
- (BOOL)hd_isValidEmail;

/**
 *  判断是否是中文
 */
- (BOOL)hd_isChinese;

/**
 *  判断是不是url地址
 */
- (BOOL)hd_isValidUrl;

/**
 * 验证是否是手机号
 */
- (BOOL)hd_isValidateMobile;


#pragma mark - 限制相关
/**
 限制字符串长度
 
 @param length 限制的长度
 */
- (instancetype)hd_limitLength:(NSInteger)length;

/**
 字符串长度

 @return 返回字符串长度
 */
- (NSUInteger)hd_length;

/**
 字符串截串

 @param maxLength 最大长度
 @return 返回截取到最大长度的字符串
 */
- (instancetype)hd_substringMaxLength:(NSUInteger)maxLength;

@end
