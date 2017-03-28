//
//  CMLineChartView.h
//  CMChart
//
//  Created by 23 on 2017/3/28.
//  Copyright © 2017年 23. All rights reserved.
//
/**
 折线图
 
 */

#import <UIKit/UIKit.h>

@interface CMLineChartView : UIView

/**
 设置标题
 
 @param mainTitle 主标题
 @param secondTitle 副标题
 @param thirdTitle 副副标题
 */
- (void)setMainTitle:(NSString *)mainTitle  secondTitle:(NSString *)secondTitle thirdTitle:(NSString *)thirdTitle;

/**
 设置标题及其标题属性
 
 @param mainTitle 主标题
 @param mainAttribute 主标题的属性字典
 @param secondTitle 副标题
 @param secondAttribute 副标题的属性字典
 @param thirdTitle 副副标题
 @param thirdAttribute 副副标题的属性字典
 */
- (void)setMainTitle:(NSString *)mainTitle mainTitleAttribute:(NSDictionary *)mainAttribute secondTitle:(NSString *)secondTitle secondTitleAttribute:(NSDictionary *)secondAttribute thirdTitle:(NSString *)thirdTitle thirdTitleAttribute:(NSDictionary *)thirdAttribute;

/**
 设置x轴的标签数据源
 
 @param xLabels X轴标签数据源数组
 */
- (void)updateXLabels:(NSArray *)xLabels;

/**
 设置y轴数值数据源
 
 @param yValues y轴数值数据源
 */
- (void)updateYValue:(NSArray *)yValues;

@end
