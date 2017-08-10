//
//  HDMacro.h
//  PortableTreasure
//
//  Created by HeDong on 15/03/20.
//  Copyright © 2015年 hedong. All rights reserved.
//

//// 判断是真机还是模拟器
//#if TARGET_OS_IPHONE
//// iPhone Device
//#endif
//
//#if TARGET_IPHONE_SIMULATOR
//// iPhone Simulator
//#endif


#ifdef __cplusplus
#define HD_EXTERN		extern "C" __attribute__((visibility ("default")))
#else
#define HD_EXTERN	        extern __attribute__((visibility ("default")))
#endif


#define weakSelf(weakSelf) __weak typeof(self)weakSelf = self;
#define strongSelf(strongSelf) __strong typeof(weakSelf)strongSelf = weakSelf; if (!strongSelf) return;


// 由角度获取弧度
#define HDDegreesToRadian(x) (M_PI * (x) / 180.0)
// 由弧度获取角度
#define HDRadianToDegrees(radian) (radian * 180.0) / (M_PI)


#define HDNotificationCenter [NSNotificationCenter defaultCenter]
#define HDUserDefaults [NSUserDefaults standardUserDefaults]
#define HDFirstWindow [UIApplication sharedApplication].windows.firstObject
#define HDRootViewController HDFirstWindow.rootViewController


/******* 效验对象是否是空 *******/
#define HDStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
#define HDArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
#define HDDictionaryIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
#define HDObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
/******* 效验对象是否是空 *******/


/******* APP_INFO *******/
/** APP版本号 */
#define HDAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/** APP BUILD 版本号 */
#define HDAppBuildVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
/** APP名字 */
#define HDAppDisplayName [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
/** 当前语言 */
#define HDLocalLanguage [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode]
/** 当前国家 */
#define HDLocalCountry [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode]
/******* APP_INFO *******/


/******* 回到主线程 *******/
#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_main_async_safe(block)             \
if ([NSThread isMainThread]) {                      \
block();                                            \
} else {                                            \
dispatch_async(dispatch_get_main_queue(), block);   \
}
/******* 回到主线程 *******/


/******* RGB颜色 *******/
#define HDColorAlpha(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0  blue:(b) / 255.0  alpha:a]
#define HDColor(r, g, b) HDColorAlpha(r, g, b, 1.0)

#define HDColorFromHexAlpha(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:a]
#define HDColorFromHex(rgbValue) HDColorFromHexAlpha(rgbValue, 1.0)
/******* RGB颜色 *******/


/******* 屏幕尺寸 *******/
#define HDMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define HDMainScreenHeight [UIScreen mainScreen].bounds.size.height
#define HDMainScreenBounds [UIScreen mainScreen].bounds
/******* 屏幕尺寸 *******/


/******* 屏幕系数 *******/
#define HDiPhone6WidthCoefficient(width) (width / 375.0)    // 以苹果6为准的系数
#define HDiPhone6HeightCoefficient(height) (height / 667.0) // 以苹果6为准的系数
#define HDiPhone6ScaleWidth(width) (HDiPhone6WidthCoefficient(width) * HDMainScreenWidth)     // 以苹果6为准的系数得到的宽
#define HDiPhone6ScaleHeight(height) (HDiPhone6HeightCoefficient(height) * HDMainScreenHeight) // 以苹果6为准的系数得到的高
/******* 屏幕系数 *******/


/******* 设备型号和系统 *******/
/** 检查系统版本 */
#define HDSYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define HDSYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define HDSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define HDSYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define HDSYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define iOS5_OR_LATER  HDSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0")
#define iOS6_OR_LATER  HDSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")
#define iOS7_OR_LATER  HDSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
#define iOS8_OR_LATER  HDSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")
#define iOS9_OR_LATER  HDSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")
#define iOS10_OR_LATER HDSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")

/** 系统和版本号 */
#define HDDevice [UIDevice currentDevice]
#define HDDeviceName HDDevice.name                           // 设备名称
#define HDDeviceModel HDDevice.model                         // 设备类型
#define HDDeviceLocalizedModel HDDevice.localizedModel       // 本地化模式
#define HDDeviceSystemName HDDevice.systemName               // 系统名字
#define HDDeviceSystemVersion HDDevice.systemVersion         // 系统版本
#define HDDeviceOrientation HDDevice.orientation             // 设备朝向
//#define HDDeviceUUID HDDevice.identifierForVendor.UUIDString // UUID // 使用苹果不让上传App Store!!!
#define HDiOS8 ([HDDeviceSystemVersion floatValue] >= 8.0)   // iOS8以上
#define HDiPhone ([HDDeviceModel rangeOfString:@"iPhone"].length > 0)
#define HDiPod ([HDDeviceModel rangeOfString:@"iPod"].length > 0)
#define HDiPad (HDDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
/******* 设备型号和系统 *******/


/******* 日志打印替换 *******/
//#import <CocoaLumberjack/CocoaLumberjack.h>
#ifdef DEBUG

//#define HDLog(frmt, ...) LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagVerbose, 0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
//
//#define HDLogError(frmt, ...)   LOG_MAYBE(NO,                LOG_LEVEL_DEF, DDLogFlagError,   0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
//
//#define HDLogWarn(frmt, ...)    LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagWarning, 0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
//
//#define HDLogInfo(frmt, ...)    LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagInfo,    0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
//
//#define HDLogDebug(frmt, ...)   LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagDebug,   0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
//
//#define HDLogVerbose(frmt, ...) LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagVerbose, 0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)


#define HDAssert(...) NSAssert(__VA_ARGS__)
#define HDParameterAssert(condition) NSAssert((condition), @"Invalid parameter not satisfying: %@", @#condition)

//static const int ddLogLevel = LOG_LEVEL_VERBOSE;

#else

#define HDLog(...)
#define HDLogError(frmt, ...)
#define HDLogWarn(frmt, ...)
#define HDLogInfo(frmt, ...)
#define HDLogDebug(frmt, ...)

#define HDAssert(...)
#define HDParameterAssert(condition)
//static const int ddLogLevel = LOG_LEVEL_OFF;

#endif
/******* 日志打印替换 *******/


/******* 归档解档 *******/
#define HDCodingImplementation                              \
- (void)encodeWithCoder:(NSCoder *)aCoder {                 \
unsigned int count = 0;                                     \
Ivar *ivars = class_copyIvarList([self class], &count);     \
for (int i = 0; i < count; i++) {                           \
Ivar ivar = ivars[i];                                       \
const char *name = ivar_getName(ivar);                      \
NSString *key = [NSString stringWithUTF8String:name];       \
id value = [self valueForKey:key];                          \
[aCoder encodeObject:value forKey:key];                     \
}                                                           \
free(ivars);                                                \
}                                                           \
\
- (instancetype)initWithCoder:(NSCoder *)aDecoder {         \
if (self = [super init]) {                                  \
unsigned int count = 0;                                     \
Ivar *ivars = class_copyIvarList([self class], &count);     \
for (int i = 0; i < count; i++) {                           \
Ivar ivar = ivars[i];                                       \
const char *name = ivar_getName(ivar);                      \
NSString *key = [NSString stringWithUTF8String:name];       \
id value = [aDecoder decodeObjectForKey:key];               \
[self setValue:value forKey:key];                           \
}                                                           \
free(ivars);                                                \
}                                                           \
return self;                                                \
}
/******* 归档解档 *******/
