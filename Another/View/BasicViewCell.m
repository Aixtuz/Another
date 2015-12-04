//
//  BasicViewCell.m
//  Another
//
//  Created by Aixtuz Kang on 15/12/3.
//  Copyright © 2015年 Aixtuz Kang. All rights reserved.
//

#import "BasicViewCell.h"

@implementation BasicViewCell

//!!!: 调整行高
- (void)resetLabel:(UILabel *)label withHeight:(NSInteger)height {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    // 自定义行高度
    paragraphStyle.lineSpacing = height;
    
    // 作者 Label 右对齐
    if (label.tag == 10) {
        paragraphStyle.alignment = NSTextAlignmentRight;
    }
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange (0, [label.text length])];
    label.attributedText = attributedString;
}

@end
