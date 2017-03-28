//
//  CMHistogramChartView.h
//  CMChart
//
//  Created by 23 on 2017/3/27.
//  Copyright © 2017年 23. All rights reserved.
//
/**
 直方图
 
 */

#import <UIKit/UIKit.h>

@interface CMHistogramChartView : UIView

#pragma mark - API
/**设置标题*/
- (void)setMainTitle:(NSString *)mainTitle  secondTitle:(NSString *)secondTitle thirdTitle:(NSString *)thirdTitle;

/**设置标题及其属性*/
- (void)setMainTitle:(NSString *)mainTitle mainTitleAttribute:(NSDictionary *)mainAttribute secondTitle:(NSString *)secondTitle secondTitleAttribute:(NSDictionary *)secondAttribute thirdTitle:(NSString *)thirdTitle thirdTitleAttribute:(NSDictionary *)thirdAttribute;

/**设置x轴标签*/
- (void)updateXLabels:(NSArray *)xLabels;

/**设置y轴数值*/
- (void)updateYValue:(NSArray *)yValues;

@end
