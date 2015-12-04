
//  HPViewCell.m
//  Another
//
//  Created by Aixtuz Kang on 15/11/28.
//  Copyright (c) 2015年 Aixtuz Kang. All rights reserved.
//

#import "HPViewCell.h"
#import "NSString+KCL.h"
#import "KCLNetworkTools.h"

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
- (void)setWithModel:(HPEntity *)hpEntity andDateStr:(NSString *)dateStr {

    // VOL
    self.volLabel.text = hpEntity.strHpTitle;
    
    // 图片
    [KCLNetworkTools setImageView:self.imageView withUrlStr:hpEntity.strOriginalImgUrl andDateStr:dateStr];
    
    // 作者
    self.authorLabel.text = [hpEntity.strAuthor strFormat];
    
    // 日
    NSRange dayRange = NSMakeRange(8, 2);
    self.dayLabel.text = [hpEntity.strMarketTime substringWithRange:dayRange];
    
    // 年月
    NSRange monthRange = NSMakeRange(0, 7);
    self.monthLabel.text = [hpEntity.strMarketTime substringWithRange:monthRange];
    
    // 内容
    self.textLabel.text = hpEntity.strContent;
    
    // 调整行高
    [self resetLabel:self.authorLabel withHeight:5];
    [self resetLabel:self.textLabel withHeight:5];
}

// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"HPViewCell" owner:nil options:nil] firstObject];
    }
    return self;
}


@end
