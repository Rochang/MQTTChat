//
//  IMMQTTManager.m
//  MQTTChat
//
//  Created by rochang on 2018/10/9.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMMQTTManager.h"
#import "IMSDKManager.h"

@interface IMMQTTManager ()<MQTTSessionDelegate>

@property (strong, nonatomic) MQTTSession *session;

@end

@implementation IMMQTTManager

+ (instancetype)shareInstance {
    static IMMQTTManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

#pragma mark - API
- (void)connectWithHost:(NSString *)host port:(UInt16)port userName:(NSString *)userName passWord:(NSString *)passWord clientId:(NSString *)clientId {
    self.session.userName = userName;
    self.session.password = passWord;
    self.session.clientId = clientId;
    [self.session connect];
}

- (void)disConnect {
    [self.session disconnect];
}


- (void)subscribeTopic:(NSString *)topic {
    [self.session subscribeToTopic:topic atLevel:MQTTQosLevelAtLeastOnce];
}

- (void)unSubscribeTopic:(NSString *)topic {
    [self.session unsubscribeAndWaitTopic:topic timeout:10];
}

//- (void)publishDataAtMostOnce:(NSData *)data onTopic:(NSString *)topic {
//    NSLog(@"发布主题 : %@", topic);
//    [self.session publishDataAtMostOnce:data onTopic:topic retain:NO];
//}

- (void)publishDataAtLeastOnce:(NSData *)data onTopic:(NSString *)topic {
    NSLog(@"发布主题 : %@", topic);
    [self.session publishDataAtLeastOnce:data onTopic:topic retain:NO];
}

#pragma mark - MQTTSessionDelegate
- (void)connected:(MQTTSession *)session {
    [self respondsToTargetSelector:@selector(MQTTConnect:) enumerateObjectsWithOptions:^(id  _Nonnull delegate) {
        [delegate MQTTConnect:session];
    }];
}

- (void)handleEvent:(MQTTSession *)session event:(MQTTSessionEvent)eventCode error:(NSError *)error {
    NSDictionary *states = @{
                             @(MQTTSessionEventConnected) : @"连接状态 : Connected",
                             @(MQTTSessionEventConnectionRefused) : @"连接状态 : ConnectionRefused",
                             @(MQTTSessionEventConnectionClosed) : @"连接状态 : ConnectionClosed",
                             @(MQTTSessionEventConnectionError) : @"连接状态 : ConnectionError",
                             @(MQTTSessionEventProtocolError) : @"连接状态 : ProtocolError",
                             @(MQTTSessionEventConnectionClosedByBroker) : @"连接状态 : ConnectionClosedByBroker"
                             };
    NSLog(@"%@", states[@(eventCode)]);
}

- (void)newMessage:(MQTTSession *)session data:(NSData *)data onTopic:(NSString *)topic qos:(MQTTQosLevel)qos retained:(BOOL)retained mid:(unsigned int)mid {
    /**
     IMCommandTypeNone         = 0,   //None
     IMCommandTypeChat         = 1,   //1:聊天
     IMCommandTypeNotification = 2,   //2:通知
     IMCommandTypeOrder        = 3,   //3:指令
     IMCommandTypeFeedback     = 4,   //4:反馈
     IMCommandResponse         = 6,   //6:响应
     IMCommandBroadcast        = 7    //7:广播
     */
    NSLog(@"%@", JsonStr(data));
    
    IMModel *model =  [IMModel modelWithJSON:JsonStr(data)];
    if (model.is_myself) return;
    if ([topic rangeOfString:@"user"].location != NSNotFound) { // 私聊
        switch (model.type) {
                // 聊天
            case IMCommandTypeChat: {
                if (model.chat.type == IMChatTypeDrawingBoard) { // 画板
                    
                } else {
                    [IMShare.conversationManager handleChatConversation:model];
                }
            }
                break;
                // 通知
            case IMCommandTypeNotification: {
                [IMShare.notificationManager handleNotification:model];
            }
                break;
                // 指令
            case IMCommandTypeOrder: {
                
            }
                break;
                // 反馈
            case IMCommandTypeFeedback: {
                
            }
                break;
                // 响应
            case IMCommandResponse: {
                [IMShare.userManager userHandldRsponse:model];
            }
                break;
                // 广播
            case IMCommandBroadcast: {
                
            }
                break;
                
            default:
                break;
        }
    }
    else if ([topic rangeOfString:@"group"].location != NSNotFound)  { // 群聊
        switch (model.type) {
            case IMCommandTypeChat: {
                
            }
                break;
            case IMCommandTypeNotification: {
                
            }
                break;
            case IMCommandTypeOrder: {
                
            }
                break;
            case IMCommandTypeFeedback: {
                
            }
                break;
            case IMCommandResponse: { // 请求数据响应
                [IMShare.groupManager groupHandldRsponse:model];
            }
                break;
            case IMCommandBroadcast: {
                
            }
                break;
                
            default:
                break;
        }
    }

}

#pragma mark - getter
- (MQTTSession *)session {
    if (!_session) {
        _session = [[MQTTSession alloc] init];
        MQTTCFSocketTransport *transport = [[MQTTCFSocketTransport alloc] init];
        transport.host = kHost;
        transport.port = Kport;
        _session.transport = transport;
        _session.delegate = self;
    }
    return _session;
}


@end
