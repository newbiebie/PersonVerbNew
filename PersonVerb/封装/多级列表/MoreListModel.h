//
//  MoreListModel.h
//  PersonVerb
//
//  Created by GongHua Guo on 2018/9/3.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 swift语言书写的model在superModel传值问题上有问题
 */

@interface MoreListModel : NSObject

@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL isRoot;
@property (strong, nonatomic) NSNumber *rowNumber;
    
@property (strong, nonatomic) NSMutableArray *modelList;
@property (strong, nonatomic) NSString *className;
@property (strong, nonatomic) MoreListModel *superModel;
@property (assign, nonatomic) NSUInteger belowCount;
 
+ (instancetype)modelWithDic:(NSDictionary *)dic;
- (NSArray *)open;
- (void)closeWithSubmodels:(NSArray *)submodels;
    
@end
