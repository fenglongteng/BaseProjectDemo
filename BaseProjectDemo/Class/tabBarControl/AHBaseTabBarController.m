//
//  AHBaseTabBarController.m
//  NiuNiuLive
//
//  Created by anhui on 17/3/15.
//  Copyright © 2017年 AH. All rights reserved.
//

#import "AHBaseTabBarController.h"
#import "AHBaseNavController.h"

@interface AHBaseTabBarController ()<UITabBarControllerDelegate>


@end

@implementation AHBaseTabBarController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

#pragma mark UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    UINavigationController *navigationController = (UINavigationController *)viewController;
//    if ([navigationController.viewControllers[0] isKindOfClass:[AHHomeViewController class]]) {
//        AHHomeViewController *homeViewController = navigationController.viewControllers[0];
//        [homeViewController changeTypeControllerWithIndex:1];
//    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
        return YES;
}


@end
