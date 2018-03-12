//
//  codeCell.m
//  TabHeaderFooter
//
//  Created by 杜文亮 on 2018/3/10.
//  Copyright © 2018年 杜文亮. All rights reserved.
//

#import "codeCell.h"

#define DScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation codeCell
{
    UILabel *_lab;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    //纯代码创建的cell不走这里，xib创建的cell可以在这里执行初始化操作
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _lab = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        _lab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_lab];
    }
    return self;
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    _lab.text = [NSString stringWithFormat:@"%ld----%ld",indexPath.section,indexPath.row];
}


@end
