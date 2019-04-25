//
//  TreeView.m
//  ZBTreeMenu
//
//  Created by qmap01 on 2019/4/23.
//  Copyright © 2019 Zhaobin. All rights reserved.
//

#import "TreeView.h"
#import "TreeNode.h"
#import "TreeCell.h"
#import "UIView+Addition.h"
@interface TreeView ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableview;
    
}
@property (nonatomic, copy) NSString *rootID;
@property (nonatomic, strong)NSMutableArray *nodes;
@property (nonatomic, strong) NSMutableArray *tempNodes;
@property (nonatomic, strong) NSMutableArray *reloadArray;

@end

@implementation TreeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _tempNodes = [NSMutableArray new];
        _reloadArray = [NSMutableArray new];
        [self initView];
    }
    return self;

}
- (void)initView {
    UIImageView *top = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, 18)];
    top.image = [UIImage imageNamed:@"box-tpic.png"];
    [self addSubview:top];
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, top.bottom, self.width, self.height-36)];
    back.backgroundColor = [UIColor grayColor];
    [self addSubview:back];
    
    UIImageView *topv = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 24)];
    topv.image = [UIImage imageNamed:@"icon-1.png"];
    [back addSubview:topv];
    UILabel *info = [[UILabel alloc]initWithFrame:CGRectMake(topv.right+2, topv.top, self.width/2, 24)];
    info.text =@"资产管理";
    info.shadowColor = [UIColor blackColor];
    info.textColor = [UIColor whiteColor];
    info.font = [UIFont systemFontOfSize:20];
    [back addSubview:info];
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(10,info.bottom+5, self.width-20,back.height-10-topv.height) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor =[UIColor whiteColor];
    _tableview.layer.masksToBounds = YES;
    _tableview.layer.cornerRadius = 5.f;
    _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableview registerClass:[TreeCell class] forCellReuseIdentifier:@"identifier"];
    [back addSubview:_tableview];
    
    UIImageView *bottom = [[UIImageView alloc]initWithFrame:CGRectMake(0, back.bottom, self.width, 18)];
    bottom.image = [UIImage imageNamed:@"box-bpic.png"];
    [self addSubview:bottom];

}
- (void)reloadView:(NSMutableArray *)data withRootID:(NSString *)rootid{
    _nodes = data;
    
    _rootID = rootid;
    
    [self judgeNodeIsLeafOrRoot];
    
    [self setNodesLevel];
    
    [self firstLoad];
    
    [_tableview reloadData];
}
- (void)firstLoad {
    for (int i=0; i<_nodes.count; i++) {
        TreeNode *node = _nodes[i];
        if (node.isRoot) {
            [_tempNodes addObject:node];
            if (node.isExpand) {
                [self expandNodesForParentID:node.childrenID insertIndex:[_tempNodes indexOfObject:node]];
            }
        }
    }
    [_reloadArray removeAllObjects];
}

/**
 判断节点为子节点或父节点
 */
-  (void)judgeNodeIsLeafOrRoot {
    for (int i=0; i<_nodes.count; i++) {
        TreeNode *node = _nodes[i];
        //判断node的节点性质
        BOOL isLeaf = YES;
        BOOL isRoot = YES;
        for (TreeNode *temp in _nodes) {
            if ([temp.parentID isEqualToString:node.childrenID]) {
                //node is a root of temp ;
                isLeaf = NO;
            }
            if ([temp.childrenID isEqualToString:node.parentID]) {
                //node is a leaf of temp ;
                isRoot = NO;
            }
            if (!isRoot &&!isLeaf) {
                break;
            }
        }
        node.leaf = isLeaf;
        node.root = isRoot;
    }
   
}

/**
 设置节点Depath (更新nodes)
 */
- (void)setNodesLevel {
   
    [self setDepath:1 parentIDs:@[_rootID] childrenNodes:_nodes];
    
}

/**
 设置node level

 @param level level 从1开始叠加
 @param parentIDs 父节点集合
 @param childrenNodes 未处理子节点集合
 */
- (void)setDepath:(NSInteger)level
        parentIDs:(NSArray *)parentIDs
    childrenNodes:(NSMutableArray *)childrenNodes {
    NSMutableArray *updateParentIDs = [NSMutableArray new];
    NSMutableArray *leftNodes = [childrenNodes mutableCopy];

    for (TreeNode *temp in childrenNodes) {
        //判断节点temp是否为该parentIDs层
        if ([parentIDs containsObject:temp.parentID]) {
            temp.level = level;
            //剔除属于该level层节点
            [leftNodes removeObject:temp];
            //获取该level层childrenID更新为parentIDs同剩余节点匹配
            [updateParentIDs addObject:temp.childrenID];
        }
    }
    if (leftNodes.count>0) {
        level+=1;
        [self setDepath:level parentIDs:[updateParentIDs copy] childrenNodes:leftNodes];
    }
}
#pragma mark - UITableView delegate datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tempNodes.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TreeCell *cell = [TreeCell cellWithTableview:tableView];
    cell.node = [_tempNodes objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TreeNode *currentNode = [_tempNodes objectAtIndex:indexPath.row];
    if (currentNode.isLeaf) {
        NSLog(@"层级：%ld，节点ID：%@",currentNode.level,currentNode.childrenID);
        return;
    }else {
        currentNode.expand = !currentNode.expand;
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

    [_reloadArray removeAllObjects];
    
    if (currentNode.isExpand) {
        [self expandNodesForParentID:currentNode.childrenID insertIndex:indexPath.row];
        [tableView insertRowsAtIndexPaths:_reloadArray withRowAnimation:UITableViewRowAnimationNone];
    }else {
        [self foldNodesForLevel:currentNode.level currentIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:_reloadArray withRowAnimation:UITableViewRowAnimationNone];
        
    }


}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
#pragma mark - 折叠打开控制
/**
 插入子节点集合(打开)
 
 @param parentID 当前节点父节点
 @param insertIndex 插入节点在集合中的位置
 @return 插入节点集合对应最新index [1,1,1,1] ->[1,1,插入点,1,1]  -> 2
 */
- (NSUInteger)expandNodesForParentID:(NSString*)parentID insertIndex:(NSUInteger)insertIndex {
    for (int i=0; i<_nodes.count; i++) {
        TreeNode *temp = _nodes[i];
        if ([temp.parentID isEqualToString:parentID]) {
            //遍历节点temp归属parentID<->node 则将temp插入node后,更新insertIndex
            insertIndex++;
            [_tempNodes insertObject:temp atIndex:insertIndex];
            [_reloadArray addObject:[NSIndexPath indexPathForRow:insertIndex inSection:0]];
            if (temp.isExpand) {
                //若该节点状态打开 则该节点ID更新为下次匹配子节点集合的parentIDb传入当前temp的index
                insertIndex = [self expandNodesForParentID:temp.childrenID insertIndex:insertIndex];
            }
        }
        
    }
    return insertIndex;
}

/**
 删除子节点集合（折叠）
 
 @param level 节点level;
 @param currentIndex 当前节点index
 */
- (void)foldNodesForLevel:(NSUInteger)level currentIndex:(NSUInteger)currentIndex{
    if (currentIndex+1<_tempNodes.count) {
        NSMutableArray *tempArr = [_tempNodes copy];
        for (NSUInteger i = currentIndex+1 ; i<tempArr.count;i++) {
            TreeNode *node = tempArr[i];
            if (node.level <= level) {
                break;
            }else{
                [_tempNodes removeObject:node];
                [_reloadArray addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
