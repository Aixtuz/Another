//
//  QuestionViewCell.h
//  Another
//
//  Created by Aixtuz Kang on 15/12/2.
//  Copyright © 2015年 Aixtuz Kang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionEntity.h"
#import "BasicViewCell.h"

@interface QuestionViewCell : BasicViewCell

// 接收数据
- (void)setWithModel:(QuestionEntity *)questionEntity;

@end
