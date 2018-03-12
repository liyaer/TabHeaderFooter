//
//  XibCell.m
//  TabHeaderFooter
//
//  Created by 杜文亮 on 2018/3/10.
//  Copyright © 2018年 杜文亮. All rights reserved.
//

#import "XibCell.h"

@interface XibCell()

@property (weak, nonatomic) IBOutlet UILabel *lab;

@end


@implementation XibCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _lab.textAlignment = NSTextAlignmentRight;
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    _lab.text = [NSString stringWithFormat:@"%ld----%ld",indexPath.section,indexPath.row];
}

@end
