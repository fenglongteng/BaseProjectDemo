//
//  AppDelegate+RootController.m
//  BaseProjectDemo
//
//  Created by ComAnvei on 2017/6/26.
//  Copyright © 2017年 FLT. All rights reserved.
//

#import "AppDelegate+RootController.h"
#import "AHBaseNavController.h"
#import "AHBaseTabBarController.h"
@implementation AppDelegate (RootController)
+ (UIWindow *)getAppdelegateWindow{
    
    return ((AppDelegate *)[UIApplication sharedApplication].delegate).window;
}

+ (UIViewController *)getAppdelegateRootViewControoler{
    
    AppDelegate *appdelegate = [AppDelegate getSelf];
    
    return appdelegate.window.rootViewController;
}

+ (UIViewController *)getNavigationTopController{
    
    UINavigationController *rootVC = (UINavigationController*)[AppDelegate getAppdelegateRootViewControoler];
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarVC = (UITabBarController *)rootVC;
        AHBaseNavController *nav = (AHBaseNavController *)tabBarVC.selectedViewController;
        return nav.topViewController;
    }else{
        return rootVC.topViewController;
    }
    
}

+(AppDelegate *)getSelf{
    
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

//设置登录控制器为根控制器
+(void)setLogVCBecomeRootViewController{
    
//    UIWindow *window =  [self getSelf].window;
//    AHLoginViewController *loginVC = [[AHLoginViewController alloc]initWithNibName:@"AHLoginViewController" bundle:nil];
//    AHBaseNavController *nav = [[AHBaseNavController alloc]initWithRootViewController:loginVC];
//    window.rootViewController = nav;
//    [window makeKeyAndVisible];
}

//设置TabBarController为跟控制器
+(void)setTabBarControllerBecomeRootViewController{
    UIWindow *window =  [self getSelf].window;
    window.rootViewController = [[AHBaseTabBarController alloc]init];
    [window makeKeyAndVisible];
}

@end
