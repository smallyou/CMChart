//
//  CMHistogramChartView.m
//  CMChart
//
//  Created by 23 on 2017/3/27.
//  Copyright © 2017年 23. All rights reserved.
//

#import "CMHistogramChartView.h"

@interface CMHistogramChartView () 

#pragma mark - UI属性
/**主标题*/
@property(nonatomic,weak) UILabel *mainTitleLabel;
/**副标题*/
@property(nonatomic,weak) UILabel *secondTitleLabel;
/**副副标题*/
@property(nonatomic,weak) UILabel *thirdTitleLabel;
/**title分割线*/
@property(nonatomic,weak) UIView *titleSepartorView;
/**chart分割线*/
@property(nonatomic,weak) UIView *chartSepartorView;

#pragma mark - 其他
/**保存x轴的标签数组*/
@property(nonatomic,strong) NSMutableArray *xLabelsArray;
/**保存直方图的数组*/
@property(nonatomic,strong) NSMutableArray *barsArray;

@end


@implementation CMHistogramChartView

#pragma mark - UI属性信息
static UIFont *_mainTitleFont;  //主标题字体
static UIColor *_mainTitleColor;
static UIFont *_secondTitleFont;
static UIColor *_secondTitleColor;
static UIFont *_thirdTitleFont;
static UIColor *_thirdTitleColor;

#pragma mark - 数据源
static NSArray *_xLabels;       //X轴的标签
static NSArray *_yValues;       //y轴数值
static CGFloat _avaibleWidth;   //图的宽度
static CGFloat _avaibleHeight;  //图的高度

#pragma mark - 其他成员变量
static CGFloat _margin = 10;            //普通间隔
static CGFloat _marginHeight = 30;      //title的高度间隔
static CGFloat _marginSepartor = 1;     //分割线的宽度
static CGFloat _barWidth = 20;          //直方图的宽度
static BOOL    _isAnimation = YES;      //默认支持动画


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupInit];
        
        [self setupUI];
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        [self setupInit];
        
        [self setupUI];
        
    }
    return self;
}

/**初始化*/
- (void)setupInit
{
    //初始化数组
    self.xLabelsArray = [NSMutableArray array];
    self.barsArray = [NSMutableArray array];
    
    /**初始化默认字体颜色*/
    _mainTitleFont = [UIFont systemFontOfSize:16.0];
    _mainTitleColor = [UIColor blackColor];
    _secondTitleFont = [UIFont systemFontOfSize:14.0];
    _secondTitleColor = [UIColor blackColor];
    _thirdTitleFont = [UIFont systemFontOfSize:16.0];
    _thirdTitleColor = [UIColor blackColor];
}


#pragma mark - 设置界面
/**设置界面*/
- (void)setupUI
{
    UIView *chartSepartorView = [[UIView alloc]init];
    chartSepartorView.backgroundColor = [UIColor colorWithRed:250/255.0 green:259/255.0 blue:250/255.0 alpha:1];
    [self addSubview:chartSepartorView];
    self.chartSepartorView = chartSepartorView;
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.mainTitleLabel) {
        CGSize size = [self.mainTitleLabel.text sizeWithAttributes:@{NSFontAttributeName:_mainTitleFont}];
        CGFloat width = size.width > 100?100:(size.width + _margin);
        self.mainTitleLabel.frame = CGRectMake(_margin, _margin, width, _marginHeight);
    }
    
    if (self.secondTitleLabel) {
        CGSize size = [self.secondTitleLabel.text sizeWithAttributes:@{NSFontAttributeName:_secondTitleFont}];
        CGFloat width = size.width > 100?100:(size.width + _margin);
        self.secondTitleLabel.frame = CGRectMake(CGRectGetMaxX(self.mainTitleLabel.frame), _margin, width, _marginHeight);
    }
    
    if (self.thirdTitleLabel) {
        CGSize size = [self.thirdTitleLabel.text sizeWithAttributes:@{NSFontAttributeName:_thirdTitleFont}];
        CGFloat width = size.width > 100?100:(size.width + _margin);
        self.thirdTitleLabel.frame = CGRectMake(self.bounds.size.width - width - _margin, _margin, width, _marginHeight);
    }
    
    if (self.titleSepartorView) {
        self.titleSepartorView.frame = CGRectMake(_margin, _margin + _marginHeight + _margin, self.bounds.size.width - _margin * 2, _marginSepartor);
    }
    
    self.chartSepartorView.frame = CGRectMake(_margin, self.bounds.size.height - _margin - _marginHeight - _margin, self.bounds.size.width - 2 * _margin , _marginSepartor);
    
    
    
    
}



#pragma mark - API
/**设置标题*/
- (void)setMainTitle:(NSString *)mainTitle secondTitle:(NSString *)secondTitle thirdTitle:(NSString *)thirdTitle
{

    if (mainTitle.length) {
        
        UILabel *mainTitleLabel = [[UILabel alloc]init];
        mainTitleLabel.font = _mainTitleFont;
        mainTitleLabel.textColor = _mainTitleColor;
        mainTitleLabel.text = mainTitle;
        [self addSubview:mainTitleLabel];
        self.mainTitleLabel = mainTitleLabel;
        
    }
    
    if (secondTitle.length) {
        
        UILabel *secondTitleLabel = [[UILabel alloc]init];
        secondTitleLabel.font = _secondTitleFont;
        secondTitleLabel.textColor = _secondTitleColor;
        secondTitleLabel.text = secondTitle;
        [self addSubview:secondTitleLabel];
        self.secondTitleLabel = secondTitleLabel;
        
    }
    
    if (thirdTitle.length) {
        
        UILabel *thirdTitleLabel = [[UILabel alloc]init];
        thirdTitleLabel.text = thirdTitle;
        [self addSubview:thirdTitleLabel];
        self.thirdTitleLabel = thirdTitleLabel;
    }
    
    if (mainTitle.length || secondTitle.length || thirdTitle.length) {
        
        UIView *titleSepartorView = [[UIView alloc]init];
        titleSepartorView.backgroundColor = [UIColor colorWithRed:250/255.0 green:259/255.0 blue:250/255.0 alpha:1];
        [self addSubview:titleSepartorView];
        self.titleSepartorView = titleSepartorView;
    }
    
    
}


/**设置x轴标签*/
- (void)updateXLabels:(NSArray *)xLabels
{
    _xLabels = xLabels;
    
    //更新数据源
    _avaibleWidth = self.bounds.size.width - _margin - _margin;
    _avaibleHeight = self.bounds.size.height - _margin - _marginHeight - _margin - _marginSepartor - _margin - _marginHeight - _marginSepartor;
    
    //更新
    [self cm_updateXLabels];
}

/**设置y轴数值*/
- (void)updateYValue:(NSArray *)yValues
{
    _yValues = yValues;
    
    //更新数据源
    _avaibleWidth = self.bounds.size.width - _margin - _margin;
    _avaibleHeight = self.bounds.size.height - _margin - _marginHeight - _margin - _marginSepartor - _margin - _marginHeight - _marginSepartor ;

    //更新表格
    [self cm_updateYBars];
}


#pragma mark - 私有方法
/**更新x轴标签*/
- (void)cm_updateXLabels
{
    CGFloat margin = ( _avaibleWidth - _barWidth - _barWidth * _xLabels.count) / (_xLabels.count - 1);
    
    //移除
    for (UILabel *label in self.xLabelsArray) {
        [label removeFromSuperview];
    }
    
    
    //添加label
    for (int i = 0; i < _xLabels.count; i++) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:12.0];
        label.text = _xLabels[i];
        [label sizeToFit];
        
        CGFloat x = 20 +  i * (_barWidth + margin);
        CGFloat y = _avaibleHeight + _margin + _marginHeight + _margin + _marginSepartor + +_margin;
       
        label.center = CGPointMake(x + 0.5 * _barWidth, y + 0.5 * _marginHeight);
        
        [self.xLabelsArray addObject:label];    //添加索引
        [self addSubview:label];
    }
    
    
}

/**更新y轴数值*/
- (void)cm_updateYBars
{
    CGFloat margin = ( _avaibleWidth - 20 - 20 * _xLabels.count) / (_xLabels.count - 1);
    
    //移除
    for (CALayer *layer in self.barsArray) {
        
        if (_isAnimation) {
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            animation.fromValue = @1;
            animation.toValue = @0;
            animation.duration = 0.5;
            [layer addAnimation:animation forKey:@""];
        }
        
        [layer removeFromSuperlayer];
    }
    
    
    //添加
    for (int i = 0; i < _yValues.count; i++) {
        
        //获取最大的x/y
        [self getMaxMinYValue:^(CGFloat min, CGFloat max) {
            
            //计算每单位高度
            CGFloat perHeight = ( _avaibleHeight - 2 * _margin ) / max;
            
            //计算当前的y轴值对应的高度
            CGFloat height = perHeight * [_yValues[i] floatValue];
            
            //计算坐标
            CGFloat x = 20 +  i * (20 + margin);
            CGFloat y = _avaibleHeight + 51 - height - _margin;
            
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.frame = CGRectMake(x, y, _barWidth, height);
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(_margin, height)];
            [path addLineToPoint:CGPointMake(_margin, 0)];
            layer.path = path.CGPath;
            layer.strokeColor = [UIColor whiteColor].CGColor;
            layer.lineWidth = _barWidth;
            layer.strokeStart = 0;
            //layer.lineCap = kCALineCapRound;
            [self.layer addSublayer:layer];
            [self.barsArray addObject:layer];   //添加索引
            
            if (_isAnimation) {
                CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
                animation.fromValue = @0;
                animation.toValue = @1;
                animation.duration = 0.5;
                [layer addAnimation:animation forKey:@""];
            }
            
        }];
    }
}

/**获取最大最小的Y值*/
-(void)getMaxMinYValue:(void(^)(CGFloat min, CGFloat max))completion
{
    CGFloat max = [_yValues.firstObject floatValue];
    CGFloat min = [_yValues.firstObject floatValue];
    
    for (int i = 1; i < _yValues.count; i++) {
     
        if ([_yValues[i] floatValue] > max) {
            max = [_yValues[i] floatValue];
        }
        
        if ([_yValues[i] floatValue] < min) {
            min = [_yValues[i] floatValue];
        }
        
    }
    
    completion(min, max);
}



@end




































