//
//  LCLoginViewController.m
//  MQTTChat
//
//  Created by rochang on 2018/10/9.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "LCLoginViewController.h"
#import "LCAccountViewController.h"
#import "LCMQTTManager.h"

@interface LCLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *countField;
@property (weak, nonatomic) IBOutlet UITextField *passWordField;


@end

@implementation LCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - event method

- (IBAction)clickLoginBtn:(id)sender {
    if (!self.countField.text.length || !self.passWordField.text.length) {
        NSLog(@"请输入账号和密码");
        return;
    }
    NSString *clientId = [IMTools clientId:self.countField.text];
    [LCMQTTManagerShare connectWithHost:kHost port:Kport userName:self.countField.text passWord:self.passWordField.text clientId:clientId];
}

- (IBAction)clickTestAccountBtn:(id)sender {
    LCAccountViewController *accountVc = [[LCAccountViewController alloc] init];
    WEAKSELF
    accountVc.callBackBlock = ^(LCAccountModel * _Nonnull model) {
        weakSelf.countField.text = model.account;
        weakSelf.passWordField.text = model.password;
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    [self presentViewController:accountVc animated:YES completion:nil];
}

- (IBAction)clickResetOBBtn:(id)sender {
    
}

@end
