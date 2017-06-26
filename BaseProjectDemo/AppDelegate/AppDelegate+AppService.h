//
//  AppDelegate+AppService.h
//  BaseProjectDemo
//
//  Created by ComAnvei on 2017/6/26.
//  Copyright © 2017年 FLT. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (AppService)
/**
 *  bug日志反馈
 */
- (void)registerBugly;

/**
 *  基本配置
 */
- (void)configurationLaunchUserOption;

/**
 *  友盟注册
 */
- (void)registerUmeng;

/**
 *  Mob注册
 */

- (void)registerMob;


@end
