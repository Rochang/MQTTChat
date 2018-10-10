//
//  IMMQTTManager.m
//  MQTTChat
//
//  Created by rochang on 2018/10/9.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMMQTTManager.h"

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

- (void)publishDataAtMostOnce:(NSData *)data onTopic:(NSString *)topic retain:(BOOL)retainFlag {
    [self.session publishDataAtMostOnce:data onTopic:topic retain:retainFlag];
}

- (void)publishDataAtLeastOnce:(NSData *)data onTopic:(NSString *)topic retain:(BOOL)retainFlag {
    [self.session publishDataAtLeastOnce:data onTopic:topic retain:retainFlag];
}

#pragma mark - MQTTSessionDelegate
- (void)connected:(MQTTSession *)session {
    [self respondsToTargetSelector:@selector(MQTTConnect:) enumerateObjectsWithOptions:^(id  _Nonnull delegate) {
        [delegate MQTTConnect:session];
    }];
}

- (void)handleEvent:(MQTTSession *)session event:(MQTTSessionEvent)eventCode error:(NSError *)error {
    NSDictionary *states = @{
                             @(MQTTSessionEventConnected) : @"连接 : Connected",
                             @(MQTTSessionEventConnectionRefused) : @"连接 : ConnectionRefused",
                             @(MQTTSessionEventConnectionClosed) : @"连接 : ConnectionClosed",
                             @(MQTTSessionEventConnectionError) : @"连接 : ConnectionError",
                             @(MQTTSessionEventProtocolError) : @"连接 : ProtocolError",
                             @(MQTTSessionEventConnectionClosedByBroker) : @"连接 : ConnectionClosedByBroker"
                             };
    NSLog(@"%@", states[@(eventCode)]);
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
