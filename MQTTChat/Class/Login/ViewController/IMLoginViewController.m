//
//  IMLoginViewController.m
//  MQTTChat
//
//  Created by rochang on 2018/10/9.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMLoginViewController.h"
#import "IMAccountViewController.h"
#import "IMMQTTManager.h"
#import "LCTabBarController.h"

@interface IMLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *countField;
@property (weak, nonatomic) IBOutlet UITextField *passWordField;


@end

@implementation IMLoginViewController

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
    [IMMQTTManagerShare connectWithHost:kHost port:Kport userName:self.countField.text passWord:self.passWordField.text clientId:clientId];
    [IMMQTTManagerShare addDelegate:self];
}

- (IBAction)clickTestAccountBtn:(id)sender {
    IMAccountViewController *accountVc = [[IMAccountViewController alloc] init];
    WEAKSELF
    accountVc.callBackBlock = ^(IMAccountModel * _Nonnull model) {
        weakSelf.countField.text = model.account;
        weakSelf.passWordField.text = model.password;
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    [self presentViewController:accountVc animated:YES completion:nil];
}

- (IBAction)clickResetOBBtn:(id)sender {
    
}

#pragma mark - LCMQTTManagerDelegate
- (void)MQTTConnect:(MQTTSession *)session {
    [UIApplication sharedApplication].keyWindow.rootViewController = [[LCTabBarController alloc] init];
}

@end
