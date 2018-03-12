//
//  ViewController.m
//  TabHeaderFooter
//
//  Created by 杜文亮 on 2017/9/14.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "CellDemoVC.h"
#import "codeCell.h"
#import "XibCell.h"


#define DScreenWidth [UIScreen mainScreen].bounds.size.width


#pragma mark - 类的扩展

@interface CellDemoVC ()<UITableViewDataSource,UITableViewDelegate>
{
    int _reuseTimes;
}
@property (nonatomic,strong) UITableView *tableView;

@end


#pragma mark - 类的实现

@implementation CellDemoVC

#pragma mark - 懒加载

-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        //2，cell的第二种重用机制，“必须”registerClass或者registerNib，没有例外
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"du"];
//        [_tableView registerClass:[codeCell class] forCellReuseIdentifier:@"du"];
//        [_tableView registerNib:[UINib nibWithNibName:@"XibCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"du"];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return [self reuseCell_s:indexPath];
//    return [self reuseCell_code:indexPath];
    return [self reuseCell_xib:indexPath];
}

//系统的cell
-(UITableViewCell *)reuseCell_s:(NSIndexPath *)indexPath
{
    //1，cell的第一种重用机制
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"du"];//从重用队列获取cell
    if (!cell)//重用队列未获取到cell，就创建新的cell
    {
        //系统提供默认cell，可根据initWithStyle选择系统类型
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"du"];
    }
    else
    {
        _reuseTimes++;
        NSLog(@"重用次数：%d",_reuseTimes);
    }
    //2，cell的第二种重用机制
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"du" forIndexPath:indexPath];
    
    //给cell赋值
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-----%ld",indexPath.section,indexPath.row];
    
    return cell;
}

//纯代码自定义cell
-(UITableViewCell *)reuseCell_code:(NSIndexPath *)indexPath
{
    //1，cell的第一种重用机制
    codeCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"du"];
    if (!cell)
    {
        cell = [[codeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"du"];
    }
    else
    {
        _reuseTimes++;
        NSLog(@"重用次数：%d",_reuseTimes);
    }
    //2，cell的第二种重用机制
    //    codeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"du" forIndexPath:indexPath];
    
    //给cell赋值
    cell.indexPath = indexPath;
    
    return cell;
}

//xib自定义cell
-(UITableViewCell *)reuseCell_xib:(NSIndexPath *)indexPath
{
    //1，cell的第一种重用机制
    XibCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"du"];
    if (!cell)
    {
        //xibCell的加载(创建)方式如下，单写这一句，无法复用cell，每次都是新建cell
        cell = (XibCell *)[[[NSBundle mainBundle] loadNibNamed:@"XibCell" owner:self options:nil]  lastObject];
        //KVC设置reuseIdentifier达到复用的目的(cell的reuseIdentifier属性时只读的，无法直接属性设置值。所以通过KVC达到更改reuseIdentifier值得目的)
        [cell setValue:@"du" forKey:@"reuseIdentifier"];
    }
    else
    {
        _reuseTimes++;
        NSLog(@"重用次数：%d",_reuseTimes);
    }
    //2，cell的第二种重用机制
    //    XibCell *cell = [tableView dequeueReusableCellWithIdentifier:@"du" forIndexPath:indexPath];
    
    //给cell赋值
    cell.indexPath = indexPath;
    
    return cell;
}


/*
 *   总结：尽量使用第二种重用机制，简单方便
 */

#pragma mark - viewDidLoad 初始化

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.tableView];
}


@end
