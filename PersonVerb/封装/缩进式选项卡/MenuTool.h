//
//  MenuTool.h
//  PersonVerb
//
//  Created by GongHua Guo on 2018/8/31.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SeletedBlock)(NSInteger index);
typedef NS_ENUM(NSInteger, ANIMATIONTYPE){
    NoAnimationType = 0,
    AnimationType = 1,
};

@interface MenuTool : UIView
    
    
/** 数组标签 */
@property (strong, nonatomic) NSArray *TipsArray;
    
/**常规状态颜色*/
@property (strong, nonatomic) UIColor *normolColor;
    
/**高亮状态颜色*/
@property (strong, nonatomic) UIColor *lightColor;
    
/**标签默认增加尺寸 默认不能小于 50*/
@property (assign, nonatomic) CGFloat ItemWidth;
    
/**默认文字大小*/
@property (assign, nonatomic) CGFloat FontSize;
    
/**线的颜色*/
@property (strong, nonatomic) UIColor *lineColor;

/** 选中的事件操作 */
@property (copy, nonatomic) SeletedBlock selectedBlock;
    
/**底部线占文本长度比例*/
@property (assign, nonatomic) CGFloat scale;

/** 选择结束之后的效果 默认为1*/
@property (assign, nonatomic) ANIMATIONTYPE type;

@end
