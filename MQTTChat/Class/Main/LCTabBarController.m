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
#import "LCContactsViewController.h"
#import "LCContactsViewController.h"
#import "LCDiscoverViewController.h"
#import "LCMeViewController.h"

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
    
    LCContactsViewController *contactVc = [[LCContactsViewController alloc] init];
    LCNavigationController *contactNav = [[LCNavigationController alloc] initWithRootViewController:contactVc];
    [self addChildViewController:contactNav];
    
    LCDiscoverViewController *discoverVc = [[LCDiscoverViewController alloc] init];
    LCNavigationController *discoverNav = [[LCNavigationController alloc] initWithRootViewController:discoverVc];
    [self addChildViewController:discoverNav];
    
    LCMeViewController *meVc = [[LCMeViewController alloc] init];
    LCNavigationController *meNav = [[LCNavigationController alloc] initWithRootViewController:meVc];
    [self addChildViewController:meNav];
}

- (void)setupTabBarButtons {
    UIEdgeInsets edge = UIEdgeInsetsZero;
    [self setupTabBarButtonsWithIndex:0 image:@"tabbar_mainframe" selectImage:@"tabbar_mainframeHL" imageInsets:edge title:@"会话"];
    [self setupTabBarButtonsWithIndex:1 image:@"tabbar_contacts" selectImage:@"tabbar_contactsHL" imageInsets:edge title:@"通讯录"];
    [self setupTabBarButtonsWithIndex:2 image:@"tabbar_discover" selectImage:@"tabbar_discoverHL" imageInsets:edge title:@"朋友圈"];
    [self setupTabBarButtonsWithIndex:3 image:@"tabbar_me" selectImage:@"tabbar_meHL" imageInsets:edge title:@"我的"];
}


- (void)setupTabBarButtonsWithIndex:(NSUInteger)index image:(NSString *)image selectImage:(NSString *)selectImage imageInsets:(UIEdgeInsets)imageInsets title:(NSString *)title {
    
    UINavigationController *navC = self.childViewControllers[index];
    navC.tabBarItem.title = title;
    navC.tabBarItem.image = [Image(image) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navC.tabBarItem.selectedImage = [Image(selectImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navC.tabBarItem.imageInsets = imageInsets;
}

@end
