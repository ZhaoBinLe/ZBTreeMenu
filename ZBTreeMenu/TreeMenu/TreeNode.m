//
//  TreeNode.m
//  ZBTreeMenu
//
//  Created by qmap01 on 2019/4/23.
//  Copyright © 2019 Zhaobin. All rights reserved.
//

#import "TreeNode.h"

@implementation TreeNode
+ (instancetype)cellWithNodeInfomation:(NSDictionary *)dict {
    TreeNode *treeNode = [[TreeNode alloc]initCellWithNodeInfomation:dict];
    return treeNode;
}
- (instancetype)initCellWithNodeInfomation:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
