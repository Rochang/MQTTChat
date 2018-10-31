//
//  IMMeViewController.m
//  MQTTChat
//
//  Created by rochang on 2018/9/28.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMMeViewController.h"
#import "IMMQTTManager.h"
#import "IMLoginViewController.h"

@interface IMMeViewController ()

@end

@implementation IMMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setupNavBar {
    self.navigationItem.rightBarButtonItem = [LCView barButtonItemWithTitle:@"退出" action:^(id sender) {
        [MQTTShare disConnect];
        [UIApplication sharedApplication].keyWindow.rootViewController = [[IMLoginViewController alloc] init];
    }];
}

@end
