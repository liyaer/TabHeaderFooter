//
//  ViewController.m
//  TabHeaderFooter
//
//  Created by 杜文亮 on 2017/9/14.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "SectionHFViewVC.h"
#import "codeCell.h"
#import "CodeHeader.h"
#import "XibHeader.h"


#define DScreenWidth [UIScreen mainScreen].bounds.size.width


#pragma mark - 类的扩展

@interface SectionHFViewVC ()<UITableViewDataSource,UITableViewDelegate>
{
    int _reuseTimes;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UILabel *titleLabel;

@end


#pragma mark - 类的实现

@implementation SectionHFViewVC

#pragma mark - 懒加载

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
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[codeCell class] forCellReuseIdentifier:@"du"];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"du" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-----%ld",indexPath.section,indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

//section头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //对于同种类型的header，进行复用
//    return [self reuseHeader_s:section];
//    return [self reuseHeader_code:section];
    return [self reuseHeader_xib:section];
}

//section尾视图
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    //footer的用法和header一样，这里仅以操作header为例
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




#pragma mark - 封装方法调用集合

//对于同种类型的header，进行复用。systemHeader
-(UIView *)reuseHeader_s:(NSInteger)section
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
    else
    {
        _reuseTimes++;
        NSLog(@"重用次数：%d",_reuseTimes);
    }
    
    //给header赋值
    UILabel *titleLabel = (UILabel *)[header viewWithTag:10086];
    titleLabel.text = [NSString stringWithFormat:@"--------%ld--------",section];
    
    return header;
}

//纯代码自定义header
-(UIView *)reuseHeader_code:(NSInteger)section
{
    CodeHeader *header = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"wen"];
    if (!header)
    {
        header = [[CodeHeader alloc] initWithReuseIdentifier:@"wen"];
    }
    else
    {
        _reuseTimes++;
        NSLog(@"重用次数：%d",_reuseTimes);
    }
    header.section = section;
    return header;
}

//xib自定义header
-(UIView *)reuseHeader_xib:(NSInteger)section
{
    XibHeader *header = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"wen"];
    if (!header)
    {
        //从xib加载（创建）cell（和XibCell完全类似）
        header = (XibHeader *)[[NSBundle mainBundle] loadNibNamed:@"XibHeader" owner:self options:nil][0];
        [header setValue:@"wen" forKey:@"reuseIdentifier"];
    }
    else
    {
        _reuseTimes++;
        NSLog(@"重用次数：%d",_reuseTimes);
    }
    header.section = section;
    return header;
}




#pragma mark - viewDidLoad 初始化

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.tableView];
}


@end
