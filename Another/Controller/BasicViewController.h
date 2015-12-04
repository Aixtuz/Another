//
//  BasicViewController.h
//  Another
//
//  Created by Aixtuz Kang on 15/12/3.
//  Copyright © 2015年 Aixtuz Kang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicViewController : UICollectionViewController

// 设置 flow
- (void)layoutWithFlow:(UICollectionViewFlowLayout *)flow;

// date --> str
- (NSString *)strWithDate:(NSDate *)date;

@end
