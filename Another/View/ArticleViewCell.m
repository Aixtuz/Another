//
//  ArticleViewCell.m
//  Another
//
//  Created by Aixtuz Kang on 15/12/1.
//  Copyright © 2015年 Aixtuz Kang. All rights reserved.
//

#import "ArticleViewCell.h"

@interface ArticleViewCell ()
///  日期
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
///  标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
///  作者
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
///  内容
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
///  姓名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
///  简介
@property (weak, nonatomic) IBOutlet UILabel *authorInfo;

@end

@implementation ArticleViewCell

// 接收数据
- (void)setWithModel:(ArticleEntity *)articleEntity {
    
    // 日期
    self.dateLabel.text = articleEntity.strContMarketTime;
    
    // 标题
    self.titleLabel.text = articleEntity.strContTitle;
    
    // 作者
    self.authorLabel.text = articleEntity.strContAuthor;
    
    // 内容
    NSMutableString *str = [NSMutableString stringWithString:articleEntity.strContent];
    self.contentLabel.text = [str stringByReplacingOccurrencesOfString:@"<br>" withString:@"\r\n"];
    
    // 姓名
    self.nameLabel.text = articleEntity.strContAuthor;
    
    // 简介
    self.authorInfo.text = articleEntity.sAuth;
    
    // 调整行高
    [self resetLabel:self.contentLabel withHeight:10];
}

// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ArticleViewCell" owner:nil options:nil] firstObject];
    }
    return self;
}

@end
