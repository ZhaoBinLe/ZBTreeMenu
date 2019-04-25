//
//  TreeView.h
//  ZBTreeMenu
//
//  Created by qmap01 on 2019/4/23.
//  Copyright © 2019 Zhaobin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TreeView : UIView
/**eg:
 
 @[@{@"parentID":@"0", @"name":@"Node1", @"childrenID":@"1"},
 @{@"parentID":@"1", @"name":@"Node10", @"childrenID":@"10"},
 @{@"parentID":@"1", @"name":@"Node11", @"childrenID":@"11"},
 
 @{@"parentID":@"0", @"name":@"Node2", @"childrenID":@"2"},
 @{@"parentID":@"2", @"name":@"Node20", @"childrenID":@"20"},
 @{@"parentID":@"20", @"name":@"Node200", @"childrenID":@"200"},
 0 为RootID parentID为节点的父节点ID childrenID为节点自身ID
 */
/**
 刷新页面

 @param data TreeNode集合
 @param rootid RootID第一级节点的ParentID
 */
- (void)reloadView:(NSMutableArray *)data withRootID:(NSString *)rootid;
@end

NS_ASSUME_NONNULL_END
