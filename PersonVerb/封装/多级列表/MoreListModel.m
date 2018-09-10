//
//  MoreListModel.m
//  PersonVerb
//
//  Created by GongHua Guo on 2018/9/3.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

#import "MoreListModel.h"

@implementation MoreListModel

+ (instancetype)modelWithDic:(NSDictionary *)dic {
    MoreListModel *foldCellModel = [MoreListModel new];
    foldCellModel.title = dic[@"title"];
    foldCellModel.rowNumber = dic[@"rowNumber"];
    foldCellModel.belowCount = 0;
    foldCellModel.className = dic[@"className"];
    foldCellModel.isRoot = [dic[@"isRoot"] boolValue];
    
    foldCellModel.modelList = [NSMutableArray new];
    NSArray *submodels = dic[@"modelList"];
    for (int i = 0; i < submodels.count; i++) {
        MoreListModel *submodel = [MoreListModel modelWithDic:(NSDictionary *)submodels[i]];
        submodel.superModel = foldCellModel;
        [foldCellModel.modelList addObject:submodel];
    }
    
    return foldCellModel;
}
    
- (NSArray *)open {
    NSArray *submodels = self.modelList;
    self.modelList = nil;
    self.belowCount = submodels.count;
    return submodels;
}
    
- (void)closeWithSubmodels:(NSArray *)submodels {
    self.modelList = [NSMutableArray arrayWithArray:submodels];
    self.belowCount = 0;
}
    
- (void)setBelowCount:(NSUInteger)belowCount {
    self.superModel.belowCount += (belowCount - _belowCount);
    _belowCount = belowCount;
}

    
@end
