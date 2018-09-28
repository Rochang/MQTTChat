//
//  LCChatListViewController.m
//  MQTTChat
//
//  Created by rochang on 2018/9/27.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "LCChatListViewController.h"

@interface LCChatListViewController ()

@end

@implementation LCChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%f", self.tabBarController.tabBar.height_gs);
    NSLog(@"%f", self.navigationController.navigationBar.height_gs);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
