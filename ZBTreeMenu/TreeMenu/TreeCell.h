//
//  TreeCell.h
//  ZBTreeMenu
//
//  Created by qmap01 on 2019/4/23.
//  Copyright © 2019 Zhaobin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreeNode.h"
NS_ASSUME_NONNULL_BEGIN

@interface TreeCell : UITableViewCell
@property (nonatomic, strong)TreeNode *node;
+ (instancetype)cellWithTableview:(UITableView *)tableview;
@end

NS_ASSUME_NONNULL_END
