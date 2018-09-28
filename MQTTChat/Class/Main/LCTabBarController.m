//
//  LCTabBarController.m
//  MQTTChat
//
//  Created by rochang on 2018/9/27.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "LCTabBarController.h"
#import "LCChatListViewController.h"
#import "LCNavigationController.h"

@interface LCTabBarController ()

@end

@implementation LCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 控制器
    [self setupChildViewControllers];
    // TabBarButton
    [self setupTabBarButtons];
}

- (void)setupChildViewControllers {
    LCChatListViewController *chatVc = [[LCChatListViewController alloc] init];
    LCNavigationController *chatNav = [[LCNavigationController alloc] initWithRootViewController:chatVc];
    [self addChildViewController:chatNav];
    
    LCChatListViewController *chatVc1 = [[LCChatListViewController alloc] init];
    LCNavigationController *chatNav1 = [[LCNavigationController alloc] initWithRootViewController:chatVc1];
    [self addChildViewController:chatNav1];
    
    LCChatListViewController *chatVc2 = [[LCChatListViewController alloc] init];
    LCNavigationController *chatNav2 = [[LCNavigationController alloc] initWithRootViewController:chatVc2];
    [self addChildViewController:chatNav2];
}

- (void)setupTabBarButtons {
    
}


- (void)setupTabBarButtonsWithIndex:(NSUInteger)index image:(NSString *)image selectImage:(NSString *)selectImage imageInsets:(UIEdgeInsets)imageInsets title:(NSString *)title {
    
    UINavigationController *navC = self.childViewControllers[index];
    navC.tabBarItem.title = title;
    navC.tabBarItem.image = [Image(image) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navC.tabBarItem.selectedImage = [Image(selectImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navC.tabBarItem.imageInsets = imageInsets;
}

@end
