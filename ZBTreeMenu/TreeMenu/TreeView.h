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
/**
 刷新页面

 @param data TreeNode集合
 @param rootid RootID第一级节点的ParentID
 */
- (void)reloadView:(NSMutableArray *)data withRootID:(NSString *)rootid;
@end

NS_ASSUME_NONNULL_END
