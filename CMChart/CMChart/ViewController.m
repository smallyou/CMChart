//
//  ViewController.m
//  CMChart
//
//  Created by 23 on 2017/3/27.
//  Copyright © 2017年 23. All rights reserved.
//

#import "ViewController.h"
#import "CMChart/CMChart.h"


@interface ViewController ()
/**直方图*/
@property(nonatomic,weak) CMHistogramChartView *chartView;

/**折线图*/
@property(nonatomic,weak) CMLineChartView *lineView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupHistogramView];
    
    
}

- (void)setupHistogramView
{
    CMHistogramChartView *chartView = [[CMHistogramChartView alloc]initWithFrame:CGRectMake(10, 100, self.view.bounds.size.width - 20, 300)];
    chartView.backgroundColor = [UIColor greenColor];
    [chartView setMainTitle:@"步数:5000" secondTitle:@"日平均值:14444" thirdTitle:@"今天14:30"];
    [chartView updateXLabels:@[@"3月1日",@"3月2日",@"3月3日",@"3月4日",@"3月5日"]];
    [chartView updateYValue:@[@171,@245,@311,@4,@152]];
    self.chartView = chartView;
    [self.view addSubview:chartView];

}

- (void)setupLineView
{
    CMLineChartView *lineView = [[CMLineChartView alloc]initWithFrame:CGRectMake(10, 100, self.view.bounds.size.width - 20, 300)];
    lineView.backgroundColor = [UIColor greenColor];
    [lineView setMainTitle:@"步数:5000" secondTitle:@"日平均值:14444" thirdTitle:@"今天14:30"];
    [lineView updateXLabels:@[@"3月1日",@"3月2日",@"",@"",@"",@"sdf"]];
    [lineView updateYValue:@[@171,@245,@311,@4,@152,@82,@12]];
    [self.view addSubview:lineView];
    self.lineView = lineView;
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.lineView updateXLabels:@[@"2-1",@"2-2",@"2-3",@"2-4"]];
    [self.lineView updateYValue:@[@1,@2,@3,@4,@5]];
    
    [self.chartView updateXLabels:@[@"2-1",@"2-2",@"2-3",@"2-4"]];
    [self.chartView updateYValue:@[@1,@2,@3,@4,@5,@2,@3,@4,@5,@2,@3,@4,@5,@2,@3,@4,@5,@2,@3,@4,@5,@2,@3,@4,@5,@2,@3,@4,@5,@2,@3,@4,@5,@2,@3,@4,@5,@2,@3,@4,@5,@2,@3,@4,@5,@2,@3,@4,@5,@2,@3,@4,@5,@2,@3,@4,@5,@2,@3,@4,@5,@2,@3,@4,@5,@2,@3,@4,@5,@2,@3,@4,@5,@2,@3,@4,@5,@2,@3,@4,@5,@2,@3,@4,@5,@2,@3,@4,@5]];
}




@end
