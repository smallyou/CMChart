//
//  CMHistogramChartView.h
//  CMChart
//
//  Created by 23 on 2017/3/27.
//  Copyright © 2017年 23. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMHistogramChartView : UIView

#pragma mark - API
/**配置字体和颜色（主题、副标题、副副标题）*/
- (void)configFontWithColor;

/**设置标题*/
- (void)setMainTitle:(NSString *)mainTitle  secondTitle:(NSString *)secondTitle thirdTitle:(NSString *)thirdTitle;

/**设置x轴标签*/
- (void)updateXLabels:(NSArray *)xLabels;

/**设置y轴数值*/
- (void)updateYValue:(NSArray *)yValues;

@end
