//
//  LCBaseViewController.m
//  MQTTChat
//
//  Created by rochang on 2018/9/28.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "LCBaseViewController.h"

@interface LCBaseViewController ()

@end

@implementation LCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupNavBar];
    self.view.backgroundColor = Color_white;
}

- (void)setupUI {}

- (void)setupNavBar {}

@end
