//
//  IMContactsViewController.m
//  MQTTChat
//
//  Created by rochang on 2018/9/28.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMContactsViewController.h"

static NSString *cellId = @"cellId";

@interface IMContactsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tabelView;
@property (strong, nonatomic) NSArray <IMUserModel *>*firends;
@property (strong, nonatomic) NSArray <IMGroupModel *>*groups;

@end

@implementation IMContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firends = [IMShare.userManager getFriendsList];
    self.groups = [IMShare.userManager getGroupsList];
}

- (void)setupUI {
    [self.view addSubview:self.tabelView];
}

- (void)setupNavBar {
    self.navigationItem.title = @"通讯录";
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.groups.count;
    }
    else if (section == 1) {
        return self.firends.count;
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = self.groups[indexPath.row].Id;
        cell.detailTextLabel.text = self.groups[indexPath.row].name;
    }
    else if (indexPath.section == 1) {
        cell.textLabel.text = self.firends[indexPath.row].Id;
        cell.detailTextLabel.text = self.firends[indexPath.row].nick;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld - %ld", indexPath.section, indexPath.row);
}

#pragma mark - getter
- (UITableView *)tabelView {
    if (!_tabelView) {
        _tabelView = [LCView tableViewWithFrame:CGRectMake(0, KNavBar_H, self.view.width_gs, self.view.height_gs - KNavBar_H - KTabBar_H) style:0 dataSource:self delegate:self];
    }
    return _tabelView;
}

@end
