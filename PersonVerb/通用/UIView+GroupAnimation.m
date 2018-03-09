//
//  UIView+GroupAnimation.m
//  PersonVerb
//
//  Created by GongHua Guo on 2018/3/9.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

#import "UIView+GroupAnimation.h"
#import "UIImage+Commen.h"

//角度转化弧度
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

//#define kCircleRadius
#define kCircleTime 3.0
#define kStartCircleNum 3.0
#define particleNum 30

@implementation UIView (GroupAnimation)

- (void)startAnimation {
    
    for (int i = 0; i < particleNum; i ++) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1*i * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self customSubviewsWithRate:(particleNum-i)/(particleNum * 2.0)];
        });
    }
}

#define mark - Animate Method
- (void)customSubviewsWithRate:(CGFloat)rate {
    UIView *animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self insertSubview:animationView atIndex:0];
    
    
    CAEmitterLayer *emitter = [CAEmitterLayer new];
    emitter.emitterPosition = CGPointMake(animationView.frame.size.width / 2, animationView.frame.size.height/2.0);

    emitter.emitterShape = kCAEmitterLayerPoint;
    emitter.emitterSize = CGSizeMake(0.5 * rate, 0.5 * rate);
    emitter.shadowOpacity = 0.7;
    emitter.shadowColor = [UIColor whiteColor].CGColor;
    
    
    CAEmitterCell *star = [self makeEmitterCellRate:rate];
    
    emitter.emitterCells = @[star];
    [animationView.layer addSublayer:emitter];
    
    
    CAKeyframeAnimation *loopingAnimation = [self loopingPathAnimation];
    CAKeyframeAnimation *pathAnimation2 = [self circlePathAnimation];
    CABasicAnimation *rotationAnimation = [self rotationAnimation];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = YES;
    [group setAnimations:[NSArray arrayWithObjects:pathAnimation2,loopingAnimation,rotationAnimation,  nil]];
    group.duration = 1000.f;
    group.repeatCount = HUGE_VALF;
    [animationView.layer addAnimation:group forKey:@"groupAnimation"];
}

- (CAEmitterCell *)makeEmitterCellRate:(CGFloat)rate {
    CAEmitterCell *cell = [CAEmitterCell new];
    cell.velocity = 100;
    cell.emissionLongitude = DEGREES_TO_RADIANS(60);
    cell.emissionRange = M_PI_4*0.5 *rate;
    cell.yAcceleration = 10;
    cell.xAcceleration = -10;
    cell.scale = 0.4;
    cell.lifetime = [self randFloatBetween:0.3 and:0.75];
    cell.lifetimeRange = [self randFloatBetween:0.6 and:1.5];
    cell.contents = (id)[[self imgWithSize:CGSizeMake(10*rate, 10*rate)] CGImage];
    cell.birthRate = 20*rate;
    return cell;
}

#pragma mark - private
- (UIImage *)imgWithSize:(CGSize)size {
    UIImage *img = [UIImage imageWithColor:[UIColor whiteColor] withFrame:CGRectMake(0, 0, size.width, size.height)];
    img = [img clipImageWithRadius:size.width/2.0];
    return img;
}

- (CGFloat)randFloatBetween:(float)low and:(float)high {
    float diff = high - low;
    return (((float) rand() / RAND_MAX) * diff) + low;
}

//螺旋路径
- (CAKeyframeAnimation *)loopingPathAnimation {
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationLinear;
    pathAnimation.fillMode = kCAFillModeRemoved;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.duration = kCircleTime * kStartCircleNum;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSMutableArray *array = [NSMutableArray array];
    CGFloat radius = self.frame.size.width / 2;
    for (CGFloat angle = M_PI; angle < kStartCircleNum*2.0*M_PI + M_PI; angle = angle + 0.3) {
//        CGFloat x = 10*angle*cos(angle) + self.frame.size.width/2.0;
//        CGFloat y = 10*angle*sin(angle) +self.frame.size.height/2.0;
//        if (10*angle > radius) {
            CGFloat x = radius*cos(angle) + self.frame.size.width/2.0;
            CGFloat y = radius*sin(angle) + self.frame.size.height/2.0;
//        }
        NSValue *value = [NSValue valueWithCGPoint:CGPointMake(x, y)];
        [array addObject:value];
    }
    [path moveToPoint:[array.firstObject CGPointValue]];
    for (int i = 0; i < array.count; i ++ ) {
        CGPoint point1 = [array[i] CGPointValue];
        [path addLineToPoint:point1];
    }
    pathAnimation.path = [path CGPath];
    return pathAnimation;
}

- (CAKeyframeAnimation *)circlePathAnimation {
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationLinear;
    pathAnimation.fillMode = kCAFillModeRemoved;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.duration = kCircleTime;
    pathAnimation.repeatCount = HUGE_VALF;
    pathAnimation.beginTime = kStartCircleNum*kCircleTime;
    
    //绘制圆
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSMutableArray *array = [NSMutableArray array];
    CGFloat radius = self.frame.size.width / 2;
    for (CGFloat angle = M_PI; angle < 2.0*M_PI + M_PI; angle = angle + 0.3) {
        CGFloat x = radius*cos(angle) + self.frame.size.width/2.0;
        CGFloat y = radius*sin(angle) + self.frame.size.height/2.0;
        NSValue *value = [NSValue valueWithCGPoint:CGPointMake(x, y)];
        [array addObject:value];
    }
    [path moveToPoint:[array.firstObject CGPointValue]];
    for (int i = 0; i < array.count; i ++ ) {
        CGPoint point1 = [array[i] CGPointValue];
        [path addLineToPoint:point1];
    }
    pathAnimation.path = [path CGPath];
    return pathAnimation;
}

- (CABasicAnimation *)rotationAnimation {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.fromValue = @(0);
    rotationAnimation.toValue = @(2*M_PI);
    rotationAnimation.duration = kCircleTime;
    rotationAnimation.cumulative = YES;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.repeatCount = HUGE_VALF;
    return rotationAnimation;
}


@end

