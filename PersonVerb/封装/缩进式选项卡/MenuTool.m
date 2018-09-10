//
//  MenuTool.m
//  PersonVerb
//
//  Created by GongHua Guo on 2018/8/31.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

#import "MenuTool.h"

@interface MenuTool()
    
//记录上一个点击的button
@property (strong, nonatomic) UIButton *lastButton;
    
@property (strong, nonatomic) UIView *lineView;
    
@property (assign, nonatomic) CGFloat space;
    
@property (strong, nonatomic) UIScrollView *scrollView;
    
@property (strong, nonatomic) NSMutableArray *buttonArray;
    
@end

@implementation MenuTool
    
-(NSMutableArray *)buttonArray{
    if (_buttonArray == nil){
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
}
    

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //设置默认属性
        self.normolColor = [UIColor grayColor];
        self.lightColor = [UIColor orangeColor];
        self.lineColor = [UIColor orangeColor];
        self.FontSize = 15.0;
        self.ItemWidth = 20;
        self.TipsArray = @[];
        self.space = 3;
        self.scale = 0.6;
        self.type = 1;
    }
    return self;
}
    
-(void)layoutSubviews{
    [self setUI];
}
    
#pragma  UI设置界面
-(void)setUI{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [self addSubview:_scrollView];
    
    NSInteger index = 0;
    //总长度不到屏幕宽度  这种情形下不用设置scrollView的活动范围
    if ([self SumWidthFromTipsArray]) {
        CGFloat ItemW = SCREENWIDTH / self.TipsArray.count;
        for (NSString *item in self.TipsArray){
            [self.scrollView addSubview:[self creatBuuton:item BeginX:ItemW * index itemW:ItemW Index:index]];
            index += 1;
        }
        _scrollView.contentSize = CGSizeMake(SCREENWIDTH, 0);
    }
    
    //设置scrollView活动范围
    else {
        CGFloat sumW = 0;
        for (NSString *item in self.TipsArray){
            CGFloat strWidth = [item sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize: self.FontSize]}].width + self.ItemWidth;
            [self.scrollView addSubview:[self creatBuuton:item BeginX:sumW itemW:strWidth Index:index]];
            sumW += strWidth;
            index += 1;
        }
        _scrollView.contentSize = CGSizeMake(sumW, 0);
    }
    
    //底部添加一条线
    self.lineView = [[UIView alloc] init];
    [self.scrollView addSubview:self.lineView];
    
    self.lineView.backgroundColor = self.lineColor;
    CGFloat lineW = [self.lastButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize: self.FontSize]}].width * self.scale;
    self.lineView.frame = CGRectMake(self.lastButton.center.x - lineW / 2, self.bounds.size.height - self.space, lineW, self.space - 1);
}
    
    /**
     添加一个button
     */
-(UIButton *)creatBuuton:(NSString *)title BeginX:(CGFloat)beginX itemW:(CGFloat)itemW Index:(NSInteger)index{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(beginX, 0, itemW, self.bounds.size.height - self.space)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:self.normolColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:self.FontSize];
    if (index == 0) {
        self.lastButton = button;
        [button setTitleColor:self.lightColor forState:UIControlStateNormal];
    }
    [self.buttonArray addObject:button];
    button.tag = 300 + index;
    [button addTarget:self action:@selector(toolButtonClicked:) forControlEvents: UIControlEventTouchUpInside];
    return button;
}
    
    //判断文字总长度
-(BOOL)SumWidthFromTipsArray{
    CGFloat sumWidth = 0;
    for (NSString *item in self.TipsArray){
        CGFloat strWidth = [item sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize: self.FontSize]}].width + self.ItemWidth;
        sumWidth += strWidth;
    }
    return sumWidth <= SCREENWIDTH ? YES : NO;
}
    
#pragma button点击事件方法响应
-(void)toolButtonClicked:(UIButton *)button{
    
    if (self.lastButton.tag == button.tag) {
        return;
    }
    
    //开始动画前关闭所有按钮的点击事件
    [self.buttonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = (UIButton *)obj;
        button.enabled = NO;
    }];
    
    [self.lastButton setTitleColor:self.normolColor forState:UIControlStateNormal];
    [button setTitleColor:self.lightColor forState:UIControlStateNormal];
    CGFloat lineW = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize: self.FontSize]}].width;
    CGFloat lastW = [self.lastButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize: self.FontSize]}].width;
    [UIView animateWithDuration:0.4 animations:^{
        
        CGFloat beginX = self.lastButton.center.x > button.center.x ? button.center.x - lineW * self.scale / 2 : self.lineView.frame.origin.x;
        self.lineView.frame = CGRectMake(beginX, self.lineView.frame.origin.y, fabs(button.center.x - self.lastButton.center.x) + (lineW + lastW) * self.scale / 2, self.lineView.frame.size.height);
        if (button.frame.origin.x > SCREENWIDTH / 2 && self.scrollView.contentSize.width - button.center.x > SCREENWIDTH / 2) {
            self.scrollView.contentOffset = CGPointMake(button.center.x - SCREENWIDTH / 2, 0);
        }
        else if (button.frame.origin.x < SCREENWIDTH / 2) {
            self.scrollView.contentOffset = CGPointMake(0, 0);
        }
        else if (self.scrollView.contentSize.width - button.center.x < SCREENWIDTH / 2) {
            self.scrollView.contentOffset = CGPointMake(self.scrollView.contentSize.width - SCREENWIDTH, 0);
            
        }
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.lineView.frame = CGRectMake(button.center.x - lineW * self.scale / 2, self.lineView.frame.origin.y, lineW * self.scale, self.lineView.frame.size.height);
            } completion:^(BOOL finished) {
                self.lastButton = button;
                if (self.selectedBlock) {
                    self.selectedBlock(button.tag - 300);
                }
                //启用按钮 的点击效果
                [self.buttonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    UIButton *button = (UIButton *)obj;
                    button.enabled = YES;
                }];
            }];
        }
    }];
}
@end
