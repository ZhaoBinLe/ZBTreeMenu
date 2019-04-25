//
//  MainViewController.m
//  ZBTreeMenu
//
//  Created by qmap01 on 2019/4/23.
//  Copyright © 2019 Zhaobin. All rights reserved.
//

#import "MainViewController.h"
#import "TreeView.h"
#import "TreeNode.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    TreeView *treeview = [[TreeView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:treeview];
    [treeview reloadView:[self returnData] withRootID:@"0"];
}
- (NSMutableArray *)returnData {
    NSArray *list = @[@{@"parentID":@"0", @"name":@"Node1",
                        @"childrenID":@"1",@"camera":@"YES"},
                      @{@"parentID":@"1", @"name":@"Node10",
                        @"childrenID":@"10",@"camera":@"YES"},
                      @{@"parentID":@"1", @"name":@"Node11",
                        @"childrenID":@"11",@"camera":@"YES"},
                      @{@"parentID":@"10", @"name":@"Node100", @"childrenID":@"100",@"camera":@"YES"},
                      @{@"parentID":@"10", @"name":@"Node101", @"childrenID":@"101",@"camera":@"YES"},
                      @{@"parentID":@"11", @"name":@"Node110", @"childrenID":@"110",@"camera":@"YES"},
                      @{@"parentID":@"11", @"name":@"Node111", @"childrenID":@"111",@"camera":@"YES"},
                      @{@"parentID":@"0", @"name":@"Node2", @"childrenID":@"2",@"camera":@"NO"},
                      @{@"parentID":@"2", @"name":@"Node20", @"childrenID":@"20",@"camera":@"NO"},
                      @{@"parentID":@"20", @"name":@"Node200", @"childrenID":@"200",@"camera":@"NO"},
                      @{@"parentID":@"20", @"name":@"Node101", @"childrenID":@"201",@"camera":@"NO"},
                      @{@"parentID":@"20", @"name":@"Node202", @"childrenID":@"202",@"camera":@"NO"},
                      @{@"parentID":@"2", @"name":@"Node21", @"childrenID":@"21",@"camera":@"NO"},
                      @{@"parentID":@"21", @"name":@"Node210", @"childrenID":@"210",@"camera":@"NO"},
                      @{@"parentID":@"21", @"name":@"Node211", @"childrenID":@"211",@"camera":@"NO"},
                      @{@"parentID":@"21", @"name":@"Node212", @"childrenID":@"212",@"camera":@"NO"},];
    NSMutableArray *data = [NSMutableArray new];
    for (NSDictionary *temp in list) {
        TreeNode *node = [TreeNode cellWithNodeInfomation:temp];
        [data addObject:node];
    }
    return data;

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
