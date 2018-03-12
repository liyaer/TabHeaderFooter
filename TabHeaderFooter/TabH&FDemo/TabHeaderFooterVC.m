//
//  ViewController.m
//  TabHeaderFooter
//
//  Created by 杜文亮 on 2017/9/14.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "TabHeaderFooterVC.h"


#define DScreenWidth [UIScreen mainScreen].bounds.size.width


#pragma mark - 类的扩展

@interface TabHeaderFooterVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UITableView *tableView;

@end




#pragma mark - 类的实现

@implementation TabHeaderFooterVC

#pragma mark - 懒加载

-(UIView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DScreenWidth, 80)];
        _headerView.backgroundColor = [UIColor redColor];
        [_headerView addSubview:self.titleLabel];
    }
    return _headerView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 300, 30)];
        _titleLabel.textColor = [UIColor yellowColor];
        _titleLabel.text = @"tableView的头视图";
    }
    return _titleLabel;
}

-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        //设置tableView的头、尾视图
        [_tableView setTableHeaderView:self.headerView];
    }
    return _tableView;
}




#pragma mark - tableView dateSource and delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"du"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"du"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d-----%d",indexPath.section,indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}




#pragma mark - viewDidLoad 初始化

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.tableView];
}


@end
