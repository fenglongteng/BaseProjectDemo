//
//  Tool.h
//  BaseProjectDemo
//
//  Created by ComAnvei on 2017/6/26.
//  Copyright © 2017年 FLT. All rights reserved.
//

#ifndef Tool_h
#define Tool_h

//debug模式下打印日志。
#ifdef DEBUG
#   define LOG(fmt, ...)                                             NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define LOG(...)
#endif

//图片宏
#define ImageNamed(imageName) [UIImage imageNamed:@"imageName"]


//HEX颜色转换（16进制->10进制）

#define UIColorFromHEX(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

// 设置颜色宏

#define UIColorFromRGB(r, g, b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

//弱引用self宏
#define WeakSelf __weak typeof(self) weakSelf = self
#define LTWeakSelf(type)  __weak typeof(type) weak##type = type;
#define StrongSelf __strong typeof(weakSelf) strongSelf = weakSelf

#define DefaultHeadImage [UIImage imageNamed:@"image_gongzhuuser"]

//检查字符串是否为空 采用宏是因为NSNull不会调用原类的方法
#define  TestStringIsBlank(str)   [NSString isBlankString:str]

#define TestArrayIsEmpty(array)   [NSArray IsEmptyArray:array]



#endif /* Tool_h */
