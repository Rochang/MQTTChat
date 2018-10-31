//
//  IMContactsViewController.m
//  MQTTChat
//
//  Created by rochang on 2018/9/28.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMContactsViewController.h"

@interface IMContactsViewController ()

@end

@implementation IMContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", [IMShare.userManager getFriendsList]);
    NSLog(@"%@", [IMShare.userManager getGroupsList]);
}

- (void)setupNavBar {
    self.navigationItem.title = @"通讯录";
}

@end
