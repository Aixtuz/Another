//
//  HPViewCell.m
//  Another
//
//  Created by Aixtuz Kang on 15/11/28.
//  Copyright (c) 2015年 Aixtuz Kang. All rights reserved.
//

#import "HPViewCell.h"

@interface HPViewCell ()

///  VOL
@property (weak, nonatomic) IBOutlet UILabel *volLabel;
///  图片
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
///  作者名
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
///  日
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
///  年月
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
///  内容
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation HPViewCell

// 接收数据
- (void)setWithModel:(HPEntity *)hpEntity {

    // VOL
    self.volLabel.text = hpEntity.strHpTitle;
    
    // 图片
    // NSURLConnection 异步请求(自带缓存)
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:hpEntity.strOriginalImgUrl]];
    // 异步请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        self.imageView.image = [UIImage imageWithData:data];
    }];
    
    // 作者
    NSMutableString *str = [NSMutableString stringWithString:hpEntity.strAuthor];
    //!!!: 替换换行符
    self.authorLabel.text = [str stringByReplacingOccurrencesOfString:@"&" withString:@"\r\n"];;
    
    // 日
    NSRange dayRange = NSMakeRange(8, 2);
    self.dayLabel.text = [hpEntity.strMarketTime substringWithRange:dayRange];
    
    // 年月
    NSRange monthRange = NSMakeRange(0, 7);
    self.monthLabel.text = [hpEntity.strMarketTime substringWithRange:monthRange];
    
    // 内容
    self.textLabel.text = hpEntity.strContent;
    
    // 调整行高
    [self resetContent];
}

//!!!: 调整行高
- ( void )resetContent{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.textLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5 ;  // 自定义行高度
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange (0, [self.textLabel.text length])];
    self.textLabel.attributedText = attributedString;
}

// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"HPViewCell" owner:nil options:nil] firstObject];
    }
    return self;
}


@end
