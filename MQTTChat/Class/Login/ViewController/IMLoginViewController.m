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
#import "IMPresentationController.h"
#import "IMFMDBManager.h"

@interface IMLoginViewController ()<UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UITextField *acountField;
@property (weak, nonatomic) IBOutlet UITextField *passWordField;


@end

@implementation IMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *name = [LCMethod UD_getObjectForKey:kUserName];
    NSString *passWard = [LCMethod UD_getObjectForKey:kUserPassWard];
    if (name.length && passWard.length) {
        self.acountField.text = name;
        self.passWordField.text = passWard;
    }
}

#pragma mark - event method

- (IBAction)clickLoginBtn:(id)sender {
    if (!self.acountField.text.length || !self.passWordField.text.length) {
        NSLog(@"请输入账号和密码");
        return;
    }
    NSString *clientId = [IMTools clientId];
    [MQTTShare connectWithHost:kHost port:Kport userName:self.acountField.text passWord:self.passWordField.text clientId:clientId];
    [MQTTShare addDelegate:self];
}

- (IBAction)clickTestAccountBtn:(id)sender {
    IMAccountViewController *accountVc = [[IMAccountViewController alloc] init];
    WEAKSELF
    accountVc.callBackBlock = ^(IMAccountModel * _Nonnull model) {
        weakSelf.acountField.text = model.account;
        weakSelf.passWordField.text = model.password;
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    accountVc.transitioningDelegate = self;
    // 使用自定义modal 方式
    accountVc.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:accountVc animated:YES completion:nil];
}

- (IBAction)clickResetOBBtn:(id)sender {
    [FMDBShare deleteDatabase];
}

#pragma mark - LCMQTTManagerDelegate
// 连接成功
- (void)MQTTConnect:(MQTTSession *)session {
    // 记录账号/密码
    [LCMethod UD_setObject:self.acountField.text forKey:kUserName];
    [LCMethod UD_setObject:self.passWordField.text forKey:kUserPassWard];
    // 订阅个人主题
    [MQTTShare subscribeTopic:[IMTools userTopic]];
    // 订阅系统通知主题
    [MQTTShare subscribeTopic:[IMTools systemNotificationTopic]];
    // 登录成功发送上线广播
    
    
     // 拉取好友列表
    [IMShare.userManager publishFriendsList];
    
    // 获取群组列表，订阅所有群组主题
    [IMShare.userManager publishGroupsList];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [[LCTabBarController alloc] init];
}

- (NSData *)strDataWithJsonObject:(id)object
{
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:object options:kNilOptions error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[IMPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting height:kAccountViewController_H];
}

@end
