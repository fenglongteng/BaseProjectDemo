//
//  AppDelegate+RootController.h
//  BaseProjectDemo
//
//  Created by ComAnvei on 2017/6/26.
//  Copyright © 2017年 FLT. All rights reserved.
//

#import "AppDelegate.h"

@interface  AppDelegate(RootController)
/**
 *  获取window
 *
 *  @return window
 */
+ (UIWindow *)getAppdelegateWindow;

/**
 *  获取rootViewController
 *
 *  @return rootViewController
 */
+ (UIViewController *)getAppdelegateRootViewControoler;

/**
 *  获取navigation顶部视图
 *
 *  @return topController
 */
+ (UIViewController *)getNavigationTopController;

/**
 *  返回Appdelegate
 *
 *  @return delegate
 */
+ (AppDelegate *)getSelf;


/**
 * 设置登录控制器为根控制器
 */
+(void)setLogVCBecomeRootViewController;


/**
 * 设置TabBarController为跟控制器
 */
+(void)setTabBarControllerBecomeRootViewController;
@end
