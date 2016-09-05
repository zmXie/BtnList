//
//  ViewController.m
//  BtnList
//
//  Created by xzm on 16/9/2.
//  Copyright © 2016年 ypwl. All rights reserved.
//

#import "ViewController.h"
#import "TypesetBtnList.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray *_dataArr;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = [NSMutableArray array];
    NSArray *textArr = @[@[@"美国",@"日本",@"西班牙",@"葡萄牙",@"吉尔吉斯斯坦",@"中国",@"俄罗斯",@"意大利",@"印度",@"巴基斯坦"],@[@"吉尔吉斯斯坦",@"中国",@"俄罗斯",@"意大利",@"印度",@"巴基斯坦"],@[@"俄罗斯",@"意大利",@"印度",@"巴基斯坦"],@[@"美国",@"日本",@"西班牙",@"葡萄牙",@"吉尔吉斯斯坦",@"中国"],@[@"俄罗斯",@"意大利",@"印度",@"巴基斯坦"],@[@"美国",@"日本",@"西班牙",@"葡萄牙",@"吉尔吉斯斯坦",@"中国",@"俄罗斯",@"意大利",@"印度",@"巴基斯坦",@"美国",@"西班牙"],@[@"美国",@"日本",@"西班牙",@"葡萄牙",@"吉尔吉斯斯坦",@"中国",@"俄罗斯"],@[@"美国",@"日本",@"西班牙",@"葡萄牙",@"吉尔吉斯斯坦",@"中国",@"俄罗斯",@"意大利",@"印度",@"巴基斯坦",@"意大利",@"印度",@"巴基斯坦"],@[@"美国",@"日本",@"西班牙",@"葡萄牙",@"吉尔吉斯斯坦",@"中国",@"俄罗斯",@"意大利",@"印度",@"巴基斯坦"],@[@"美国",@"日本",@"西班牙",@"葡萄牙",@"吉尔吉斯斯坦",@"中国",@"俄罗斯",@"意大利",@"印度",@"巴基斯坦"]];
    
    [textArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BtnListModel *model = [[BtnListModel alloc]init];
        model.textArray = obj;
        model.btnListwidth = 290;
        if(idx%2==0)model.isAllowMutable = NO;
        [model configData];
        [_dataArr addObject:model];
    }];
    
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, 320, 548) style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    [tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableV];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BtnListModel *model = _dataArr[indexPath.row];
    
    return model.totalHeight+20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = 0;
    
    TypesetBtnList *listv = [cell.contentView viewWithTag:100];
    if (!listv) {
        
        listv = [[TypesetBtnList alloc]initWithFrame:CGRectMake(15, 10, cell.contentView.bounds.size.width - 30, 0)];
        listv.tag = 100;
        [cell.contentView addSubview:listv];
    }
    listv.model = _dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
