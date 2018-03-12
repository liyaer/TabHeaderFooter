//
//  CodeHeader.m
//  TabHeaderFooter
//
//  Created by 杜文亮 on 2018/3/12.
//  Copyright © 2018年 杜文亮. All rights reserved.
//

#import "CodeHeader.h"

@implementation CodeHeader
{
    UILabel *_lab;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = [UIColor purpleColor];
        _lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        [self.contentView addSubview:_lab];
    }
    return self;
}

-(void)setSection:(NSInteger)section
{
    _section = section;
    _lab.text = [NSString stringWithFormat:@"---%ld---",section];
}

@end
