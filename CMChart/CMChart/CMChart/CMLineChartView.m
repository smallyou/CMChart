//
//  CMLineChartView.m
//  CMChart
//
//  Created by 23 on 2017/3/28.
//  Copyright © 2017年 23. All rights reserved.
//

#import "CMLineChartView.h"

@interface CMLineChartView()

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
/**y轴折线layer*/
@property(nonatomic,weak) CAShapeLayer *shapeLayer;

@end


@implementation CMLineChartView

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
        CGFloat width = size.width > 150?150:(size.width + _margin);
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
    [self setMainTitle:mainTitle mainTitleAttribute:nil secondTitle:secondTitle secondTitleAttribute:nil thirdTitle:thirdTitle thirdTitleAttribute:nil];
}

/**设置标题及其属性*/
- (void)setMainTitle:(NSString *)mainTitle mainTitleAttribute:(NSDictionary *)mainAttribute secondTitle:(NSString *)secondTitle secondTitleAttribute:(NSDictionary *)secondAttribute thirdTitle:(NSString *)thirdTitle thirdTitleAttribute:(NSDictionary *)thirdAttribute
{
    if (mainTitle.length) {
        
        UILabel *mainTitleLabel = [[UILabel alloc]init];
        if (mainAttribute) {
            mainTitleLabel.attributedText = [[NSAttributedString alloc]initWithString:mainTitle attributes:mainAttribute];
        }else{
            mainTitleLabel.font = _mainTitleFont;
            mainTitleLabel.textColor = _mainTitleColor;
            mainTitleLabel.text = mainTitle;
        }
        
        [self addSubview:mainTitleLabel];
        self.mainTitleLabel = mainTitleLabel;
        
    }
    
    if (secondTitle.length) {
        
        UILabel *secondTitleLabel = [[UILabel alloc]init];
        if (secondAttribute) {
            secondTitleLabel.attributedText = [[NSAttributedString alloc]initWithString:secondTitle attributes:secondAttribute];
        }else{
            secondTitleLabel.font = _secondTitleFont;
            secondTitleLabel.textColor = _secondTitleColor;
            secondTitleLabel.text = secondTitle;
        }
        [self addSubview:secondTitleLabel];
        self.secondTitleLabel = secondTitleLabel;
        
    }
    
    if (thirdTitle.length) {
        
        UILabel *thirdTitleLabel = [[UILabel alloc]init];
        if (thirdAttribute) {
            thirdTitleLabel.attributedText = [[NSAttributedString alloc]initWithString:thirdTitle attributes:thirdAttribute];
        }else{
            thirdTitleLabel.font = _thirdTitleFont;
            thirdTitleLabel.textColor = _secondTitleColor;
            thirdTitleLabel.text = thirdTitle;
        }
        
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

/**
 设置y轴数值数据源
 
 @param yValues y轴数值数据源
 */
- (void)updateYValue:(NSArray *)yValues
{
    _yValues = yValues;
    
    //更新数据源
    _avaibleWidth = self.bounds.size.width - _margin - _margin;
    _avaibleHeight = self.bounds.size.height - _margin - _marginHeight - _margin - _marginSepartor - _margin - _marginHeight - _marginSepartor;
    
    //更新
    [self cm_updateYValues];
    
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
- (void)cm_updateYValues
{
    CGFloat margin = ( _avaibleWidth - 20 - 20 * _yValues.count) / (_yValues.count - 1);
    
    //移除
    [self.shapeLayer removeFromSuperlayer];


    //获取最大最小值
    [self getMaxMinYValue:^(CGFloat min, CGFloat max) {
        
        //计算每单位高度
        CGFloat perHeight = ( _avaibleHeight - 2 * _margin ) / max;
        
        NSMutableArray *array = [NSMutableArray array];
        
        //循环产生点坐标
        for (int i = 0 ; i < _yValues.count; i++) {
            
            //计算坐标
            CGFloat height = [_yValues[i] floatValue] * perHeight;
            CGFloat y = _avaibleHeight + 51 - height - _margin;
            CGFloat x = 20 +  i * (20 + margin) + 20 * 0.5;
            CGPoint point = CGPointMake(x, y);
            [array addObject:[NSValue valueWithCGPoint:point]];
            
        }
        
        //通过坐标获取平滑曲线
        UIBezierPath *path = [self cm_SmoothedPathWithPoints:array andGranularity:50];
        
        //设置CALayer
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = CGRectMake(0, 0, _avaibleWidth, _avaibleHeight);
        shapeLayer.path = path.CGPath;
        shapeLayer.lineWidth = 2;
        shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeStart = 0;
        [self.layer addSublayer:shapeLayer];
        self.shapeLayer = shapeLayer;
        
        //添加动画
        if (_isAnimation) {
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            animation.fromValue = @0;
            animation.toValue = @1;
            animation.duration = 0.5;
            [shapeLayer addAnimation:animation forKey:@""];
        }
        
        
        
    }];
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

/**
 产生平滑曲线
    ------原理是通过在两点之间添加多个辅助点来实现平滑曲线,也就是Catmull-Rom splines
 @param pointsArray 实际曲线的点坐标
 @param granularity 在两个点坐标之间增加的辅助点的个数,点数越多，越平滑
 @return 贝塞尔平滑路径
 */
- (UIBezierPath *)cm_SmoothedPathWithPoints:(NSArray *) pointsArray andGranularity:(NSInteger)granularity {
    
    //获取点坐标数组
    NSMutableArray *points = [pointsArray mutableCopy];
    
    //设置贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //添加首尾坐标的辅助点，实现无感知平滑
    CGPoint startPoint = [points.firstObject CGPointValue];
    startPoint = CGPointMake(startPoint.x - 2, startPoint.y + 1);
    CGPoint endPoint = [points.lastObject CGPointValue];
    endPoint = CGPointMake(endPoint.x + 2, endPoint.y + 1);
    [points insertObject:[NSValue valueWithCGPoint:startPoint] atIndex:0];
    [points addObject:[NSValue valueWithCGPoint:endPoint]];
    
    //移到第一个点
    [path moveToPoint:[points.firstObject CGPointValue]];
    
    
    //添加平滑路径
    for (NSUInteger index = 1; index < points.count - 2; index++) {
        CGPoint p0 = [points[index - 1] CGPointValue];
        CGPoint p1 = [points[index] CGPointValue];
        CGPoint p2 = [points[index + 1] CGPointValue];
        CGPoint p3 = [points[index + 2] CGPointValue];
        
        //添加p1的原点
        [path addArcWithCenter:p1 radius:2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        
        //使用Catmull-Rom splines在p1和p2之间添加平滑曲线
        for (int i = 1; i < granularity; i++) {
            
            float t = (float) i * (1.0f / (float) granularity);
            float tt = t * t;
            float ttt = tt * t;
            
            //产生辅助点
            CGPoint pi;
            pi.x = 0.5 * (2*p1.x+(p2.x-p0.x)*t + (2*p0.x-5*p1.x+4*p2.x-p3.x)*tt + (3*p1.x-p0.x-3*p2.x+p3.x)*ttt);
            pi.y = 0.5 * (2*p1.y+(p2.y-p0.y)*t + (2*p0.y-5*p1.y+4*p2.y-p3.y)*tt + (3*p1.y-p0.y-3*p2.y+p3.y)*ttt);
            
            //添加辅助点
            [path addLineToPoint:pi];
        }
        
        
        //添加p2
        [path addLineToPoint:p2];
        
        
    }
    
    // finish by adding the last point
    [path addLineToPoint:[points[points.count - 1] CGPointValue]];
    
    //返回平滑路径
    return path;
}




@end
















