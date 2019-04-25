//
//  TreeNode.h
//  ZBTreeMenu
//
//  Created by qmap01 on 2019/4/23.
//  Copyright © 2019 Zhaobin. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TreeNode : BaseModel


@property (nonatomic, strong) NSString *parentID;//父类ID

@property (nonatomic, strong) NSString *childrenID;//节点自身ID

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign, getter=isCamera) BOOL camera;

@property (nonatomic, assign, getter=isLeaf) BOOL leaf;

@property (nonatomic, assign, getter=isRoot) BOOL root;

@property (nonatomic, assign, getter=isExpand) BOOL expand;

@property (nonatomic, assign) NSInteger level;

+ (instancetype)cellWithNodeInfomation:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
