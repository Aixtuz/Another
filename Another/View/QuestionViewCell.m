//
//  QuestionViewCell.m
//  Another
//
//  Created by Aixtuz Kang on 15/12/2.
//  Copyright © 2015年 Aixtuz Kang. All rights reserved.
//

#import "QuestionViewCell.h"

@interface QuestionViewCell ()

///  日期
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
///  问题
@property (weak, nonatomic) IBOutlet UILabel *questionTitle;
@property (weak, nonatomic) IBOutlet UILabel *questionContent;
///  答复
@property (weak, nonatomic) IBOutlet UILabel *answerTitle;
@property (weak, nonatomic) IBOutlet UILabel *answerContent;
///  编辑
@property (weak, nonatomic) IBOutlet UILabel *editorLabel;

@end

@implementation QuestionViewCell

// 接收数据
- (void)setWithModel:(QuestionEntity *)questionEntity {
    
    // 日期
    self.dateLabel.text = questionEntity.strQuestionMarketTime;
    
    // 提问
    self.questionTitle.text = questionEntity.strQuestionTitle;
    self.questionContent.text = questionEntity.strQuestionContent;
    
    // 回答
    self.answerTitle.text = questionEntity.strAnswerTitle;
    NSMutableString *str = [NSMutableString stringWithString:questionEntity.strAnswerContent];
    str = [NSMutableString stringWithString:[str stringByReplacingOccurrencesOfString:@"<i>" withString:@"\r\n"]];
    str = [NSMutableString stringWithString:[str stringByReplacingOccurrencesOfString:@"</i>" withString:@"\r\n"]];
    self.answerContent.text = [str stringByReplacingOccurrencesOfString:@"<br>" withString:@"\r\n"];
    
    // 编辑
    self.editorLabel.text = questionEntity.sEditor;
    
    // 调整行高
    [self resetContent];
}

// 调整行高
- (void)resetContent{
    
    NSMutableAttributedString *QuestionString = [[NSMutableAttributedString alloc] initWithString:self.questionContent.text];
    NSMutableAttributedString *answerString = [[NSMutableAttributedString alloc] initWithString:self.answerContent.text];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10 ;  // 自定义行高度
    
    [QuestionString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange (0, [self.questionContent.text length])];
    self.questionContent.attributedText = QuestionString;
    
    [answerString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange (0, [self.questionContent.text length])];
    self.answerContent.attributedText = answerString;
}

// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"QuestionViewCell" owner:nil options:nil] firstObject];
    }
    return self;
}

@end
