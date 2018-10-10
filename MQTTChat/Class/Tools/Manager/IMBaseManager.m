//
//  IMBaseManager.m
//  MQTTChat
//
//  Created by rochang on 2018/10/10.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMBaseManager.h"

@interface IMBaseManager ()
// 数组内元素弱引用
@property (nonatomic, strong) NSHashTable *delegates;

@end

@implementation IMBaseManager

#pragma mark - API
- (void)addDelegate:(id<NSObject>)delegate {
    [self.delegates addObject:delegate];
}

- (void)removeDelegate:(id<NSObject>)delegate {
    [self.delegates removeObject:delegate];
}

- (void)respondsToTargetSelector:(SEL)sel enumerateObjectsWithOptions:(void (^)(id _Nonnull))options {
    NSEnumerator *enumerator = [self.delegates objectEnumerator];
    id customer = nil;
    while (customer = [enumerator nextObject]) {
        if ([customer respondsToSelector:sel]) {
            options(customer);
        }
    }
}

#pragma mark - getter
- (NSHashTable *)delegates {
    if (!_delegates) {
        _delegates = [NSHashTable weakObjectsHashTable];
    }
    return _delegates;
}

@end
