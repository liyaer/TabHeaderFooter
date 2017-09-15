//
//  ViewController.m
//  TabHeaderFooter
//
//  Created by 杜文亮 on 2017/9/14.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "ViewController.h"


#define DScreenWidth [UIScreen mainScreen].bounds.size.width


#pragma mark - 类的扩展

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIView *headerView;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UITableView *tableView;

@end




#pragma mark - 类的实现

@implementation ViewController

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
    }
    return _titleLabel;
}

-(UITableView *)tableView
{
    if (!_tableView)
    {
#warning tableView的style为plain，section的头、尾视图、标题会有悬浮效果，group则没有。（是否悬浮只与style有关，即便当前VC是被push或者present进来的，是否悬浮也只取决与tableView的style）
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:1];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
//        //cell的第二种重用机制，需要registerClass或者registerNib（系统，自定义cell均适用）
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"du"];
        
        //设置tableView的头、尾视图
        [_tableView setTableHeaderView:self.headerView];
        _titleLabel.text = @"tableView的头视图";
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
    //cell的第一种重用机制（系统【UITableViewCell】、自定义【xxxCell】均适用）
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"du"];//从重用队列获取cell
    if (!cell)//重用队列未获取到cell，就创建新的cell
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"du"];//系统提供默认cell，可根据initWithStyle选择系统类型
        
        //通用设置可以写在这里，赋值这类操作写在外面
        cell.backgroundColor = [UIColor brownColor];
    }
    
//    //cell的第二种重用机制，需要registerClass或者registerNib（系统，自定义cell均适用）
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"du" forIndexPath:indexPath];
    
    //给cell赋值
    cell.textLabel.text = [NSString stringWithFormat:@"%d-----%d",indexPath.section,indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

#warning section的头视图、头标题同时只能存在一种
//section头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //对于同种类型的header，进行复用
    return [self reuseHeader:section];
    
    //对于只有一个或者较少的无规律的header，不进行复用
//    return [self dontReuseHeader:section];
}

//section头标题
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return section ? @"还有这种操作？" : @"除了头视图，还有头标题";
//}

//指定section头视图 \ 头标题的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
//    return section == 0 ? 40 : 0.1;
}

#warning section的尾视图、尾标题同时只能存在一种
//section尾视图
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    //footer的用法和header一样，这里仅以操作header为例
    UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"liang"];
    if (!footer)
    {
        footer = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"liang"];//系统不提供默认haeder,所以初始化方法只提供重用标识符
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        image.tag = 10010;
        [footer addSubview:image];
    }
    
    UIImageView *image = (UIImageView *)[footer viewWithTag:10010];
    image.image = [UIImage imageNamed:@"footer"];
    
    return footer;
}

//section尾标题
//-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//    return @"一切参考头标题";
//}

//指定section尾视图 \ 尾标题的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}




#pragma mark - 封装方法调用集合

//对于同种类型的header，进行复用
-(UIView *)reuseHeader:(NSInteger)section
{
    //header就这一种重用机制，和cell的机制1类似(系统【UITableViewHeaderFooterView】、自定义【xxxHeaderView】均适用；但是由于系统提供的默认header上没有任何子视图，其实都可以看成是自定义)
    UITableViewHeaderFooterView *header = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"wen"];//从重用队列获取header
    if (!header)//重用队列未获取到header，就创建新的header
    {
        //由于系统提供的默认header上没有任何子视图，其实都可以看成是自定义,所以初始化方法只提供重用标识符
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"wen"];
        
        //通用设置可以写在这里，赋值这类操作写在外面
        header.contentView.backgroundColor = [UIColor greenColor];
        
        //添加子视图
        if (_titleLabel)
        {
            _titleLabel = nil;
        }
        [header addSubview:self.titleLabel];
        _titleLabel.tag = 10086;
    }
    
    //给header赋值
    UILabel *titleLabel = (UILabel *)[header viewWithTag:10086];
    titleLabel.text = [NSString stringWithFormat:@"--------%d--------",section];
    
    return header;
}

//对于只有一个或者较少的无规律的header，不进行复用
-(UIView *)dontReuseHeader:(NSInteger)section
{
    //只有一个header
    if (section == 0)
    {
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //添加子视图
        if (_titleLabel)
        {
            _titleLabel = nil;
        }
        [headerView addSubview:self.titleLabel];
        _titleLabel.text = [NSString stringWithFormat:@"--------%d--------",section];
        return headerView;
    }
    else
    {
        return nil;//注意返回高度里也根据section做响应改变
    }

    //较少无规律的header
    //用section判断，然后分别构造各自的header即可
}




#pragma mark - viewDidLoad 初始化

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.tableView];
}


@end
