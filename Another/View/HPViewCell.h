//
//  HPViewCell.h
//  Another
//
//  Created by Aixtuz Kang on 15/11/28.
//  Copyright (c) 2015年 Aixtuz Kang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPEntity.h"

@interface HPViewCell : UICollectionViewCell

// 接收数据
- (void)setWithModel:(HPEntity *)hpEntity;

@end
