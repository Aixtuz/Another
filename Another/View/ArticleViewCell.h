//
//  ArticleViewCell.h
//  Another
//
//  Created by Aixtuz Kang on 15/12/1.
//  Copyright © 2015年 Aixtuz Kang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleEntity.h"

@interface ArticleViewCell : UICollectionViewCell

// 接收数据
- (void)setWithModel:(ArticleEntity *)articleEntity;

@end
