//
//  IMAccountViewController.m
//  MQTTChat
//
//  Created by rochang on 2018/10/9.
//  Copyright © 2018年 Rochang. All rights reserved.
//

#import "IMAccountViewController.h"
#import "MJExtension.h"

static NSString * const cellId = @"cellId";

@interface IMAccountViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *accounts;

@end

@implementation IMAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.accounts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    IMAccountModel *model = self.accounts[indexPath.row];
    cell.textLabel.text = model.account;
    cell.detailTextLabel.text = model.name;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.callBackBlock) {
        IMAccountModel *model = self.accounts[indexPath.row];
        self.callBackBlock(model);
    }
}

#pragma mark - getter
- (NSArray *)accounts {
    if (!_accounts) {
        NSArray *array = @[@{@"name":@"罗函049", @"account":@"1120130000000049", @"password":@"Sk73PmXv5SbfEBOB", @"phone":@"18818786877"},
                      @{@"name":@"罗函014", @"account":@"1120130000000014", @"password":@"klCYnIk7t9YJkTDn", @"phone":@"18818786876"},
                      @{@"name":@"李灿", @"account":@"1120130000000012", @"password":@"mEnsgex0eNOf10wN"},
                      @{@"name":@"李灿", @"account":@"1110130000000657", @"password":@"5owvFA7Wm4UU0fqV"},
                      @{@"name":@"Name", @"account":@"1110130000001171", @"password":@"CZzcypgCx5SqRzZu"},
                      @{@"name":@"Name", @"account":@"1111110000000077", @"password":@"nzGc2mJ1JMg0vvGV"},
                      @{@"name":@"Name", @"account":@"1110130000001177", @"password":@"xVRSyalatnUxwveo"},
                      @{@"name":@"pc654321",@"account":@"1120130000000164",@"password":@"meUDJldNpZwQFfQC"},
                      @{@"name":@"17620463716",@"account":@"1120130000000281",@"password":@"JyxBbGsgOTrNu2qP"},
                      @{@"name":@"tw654321",@"account":@"1120130000000308",@"password":@"xXJCKcYYFpIekG1a"},
                      @{@"name":@"朱锐",@"account":@"13824342251",@"password":@""}
                      ];
        _accounts = [IMAccountModel mj_objectArrayWithKeyValuesArray:array];
    }
    return _accounts;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [LCView tableViewWithFrame:self.view.bounds style:UITableViewStylePlain dataSource:self delegate:self];
    }
    return _tableView;
}

@end
