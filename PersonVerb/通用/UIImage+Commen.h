//
//  UIImage+Commen.h
//  PersonVerb
//
//  Created by GongHua Guo on 2018/3/9.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Commen)

+(UIImage *)imageWithColor:(UIColor *)aColor;
+(UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;

- (UIImage *)clipImageWithRadius:(CGFloat)radius;

@end
