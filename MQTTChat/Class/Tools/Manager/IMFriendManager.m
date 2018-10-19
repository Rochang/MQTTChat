//
//  IMFriendManager.m
//  MQTTChat
//
//  Created by rochang on 2018/10/19.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMFriendManager.h"
#import "IMMQTTManager.h"

@implementation IMFriendManager

- (void)getFriendsList {
    NSDictionary *dict = [NSDictionary dictionary];
    NSData *data = [self strDataWithJsonObject:dict];
    [MQTTShare publishDataAtMostOnce:data onTopic:KfriendsListTopic];
}

- (NSData *)strDataWithJsonObject:(id)object
{
    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:object options:kNilOptions error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

@end
