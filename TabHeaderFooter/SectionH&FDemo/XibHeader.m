//
//  XibHeader.m
//  TabHeaderFooter
//
//  Created by 杜文亮 on 2018/3/12.
//  Copyright © 2018年 杜文亮. All rights reserved.
//

#import "XibHeader.h"

@interface XibHeader()

@property (weak, nonatomic) IBOutlet UILabel *lab;

@end


@implementation XibHeader

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor orangeColor];
}

-(void)setSection:(NSInteger)section
{
    _section = section;
    self.lab.text = [NSString stringWithFormat:@"---%ld---",section];
}

@end
