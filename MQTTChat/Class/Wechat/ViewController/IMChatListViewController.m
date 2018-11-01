//
//  IMChatListViewController.m
//  MQTTChat
//
//  Created by rochang on 2018/9/27.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMChatListViewController.h"

static NSString *cellId = @"cellId";

@interface IMChatListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray <IMConversationModel *>*dataSource;

@end

@implementation IMChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [IMShare.conversationManager addDelegate:self];
}

- (void)setupNavBar {
    self.navigationItem.title = @"最近联系";
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    IMConversationModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.lastSession.from_user.Id;
    cell.detailTextLabel.text = model.lastSession.chat.text;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section:%zd, row:%zd", indexPath.section, indexPath.row);
}

#pragma mark - IMConversationManagerDelegate
- (void)conversationManagerFinishUpdateConversationModel:(IMModel *)model {
    IMConversationModel *conModel = [IMConversationModel modelWithIMModel:model];
    [self.dataSource addObject:conModel];
    [self.tableView reloadData];
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [LCView tableViewWithFrame:CGRectMake(0, KNavBar_H, self.view.width_gs, self.view.height_gs - KNavBar_H - KTabBar_H) style:0 dataSource:self delegate:self];
    }
    return _tableView;
}

- (NSArray<IMConversationModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [IMShare.conversationManager getAllConversations].mutableCopy;
    }
    return _dataSource;
}

@end
