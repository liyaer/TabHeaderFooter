//
//  SectionHFTitleVC.m
//  TabHeaderFooter
//
//  Created by 杜文亮 on 2018/3/10.
//  Copyright © 2018年 杜文亮. All rights reserved.
//

#import "SectionHFTitleVC.h"
#import "XibCell.h"
#import "CodeHeader.h"


#define DScreenWidth [UIScreen mainScreen].bounds.size.width


@interface SectionHFTitleVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end


@implementation SectionHFTitleVC

#pragma mark - 懒加载

-(UITableView *)tableView
{
    if (!_tableView)
    {
#warning tableView的style为plain，section的头、尾视图、标题会有悬浮效果，group则没有。（是否悬浮只与style有关，即便当前VC是被push或者present进来的，是否悬浮也只取决与tableView的style）
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerNib:[UINib nibWithNibName:@"XibCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"du"];
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
    XibCell *cell = [tableView dequeueReusableCellWithIdentifier:@"du" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

#warning section的头尾视图、头尾标题一般只设置一种,同时设置会同时存在，相互影响效果

#if 1
//section头标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section ? @"还有这种操作？" : @"除了头视图，还有头标题";
}

//section尾标题
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    //    return @"一切参考头标题";
    
    //文字过多，plain文字会折叠，无需更改高度;group文字不会折叠，需要更改高度适应文字高度
    return @"一切参考头标题=====================================================================================================================一切参考头标题";
}
#else
//section头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CodeHeader *header = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"wen"];
    if (!header)
    {
        header = [[CodeHeader alloc] initWithReuseIdentifier:@"wen"];
    }
    header.section = section;
    return header;
}

//section尾视图
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"liang"];
    if (!footer)
    {
        //系统不提供默认haeder,所以初始化方法只提供重用标识符
        footer = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"liang"];
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        image.tag = 10010;
        [footer addSubview:image];
    }
    
    UIImageView *image = (UIImageView *)[footer viewWithTag:10010];
    image.image = [UIImage imageNamed:@"footer"];
    
    return footer;
}
#endif

//指定section头视图 \ 头标题的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

//指定section尾视图 \ 尾标题的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}




#pragma mark - viewDidLoad

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
}


@end
