//
//  HPViewCell.h
//  Another
//
//  Created by Aixtuz Kang on 15/11/28.
//  Copyright (c) 2015年 Aixtuz Kang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPEntity.h"
#import "BasicViewCell.h"

@interface HPViewCell : BasicViewCell

// 接收数据
- (void)setWithModel:(HPEntity *)hpEntity andDateStr:(NSString *)dateStr;

@end
