//
//  TreeCell.m
//  ZBTreeMenu
//
//  Created by qmap01 on 2019/4/23.
//  Copyright © 2019 Zhaobin. All rights reserved.
//

#import "TreeCell.h"
#import "UIView+Addition.h"
@interface TreeCell ()

@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)UIImageView *infoView;
@property (nonatomic, strong)UILabel *nodeLabel;

@end

static CGFloat const leftMargin = 30.0;
@implementation TreeCell

+ (instancetype)cellWithTableview:(UITableView *)tableview {
    static NSString *identtifier =@"identifier";
    TreeCell *cell = [tableview dequeueReusableCellWithIdentifier:identtifier];
    if (cell ==nil) {
        cell = [[TreeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identtifier];
    }
    cell.backgroundColor =[UIColor clearColor];
    return cell;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *imgView = [[UIImageView alloc]init];
        [self.contentView addSubview:imgView];
        self.imgView = imgView;
        
        UIImageView *infoView = [[UIImageView alloc]init];
        [self.contentView addSubview:infoView];
        self.infoView = infoView;
        
        
        UILabel *nodeLabel = [[UILabel alloc]init];
        nodeLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:nodeLabel];
        self.nodeLabel = nodeLabel;
    }
    return self;
    
}
- (void)setNode:(TreeNode *)node {
    _node = node;
    _nodeLabel.text = node.name;
    if (node.isExpand) {
        _imgView.image = [UIImage imageNamed:@"minus"];
    }else {
        _imgView.image = [UIImage imageNamed:@"plus"];
    }
   
    if (node.level!=3) {
        if (node.isCamera) {
            _infoView.image = [UIImage imageNamed:@"camera"];
        }else {
            _infoView.image = [UIImage imageNamed:@"station"];
        }
        
    }
//    if (node.level!=3&&[node.childrenID isEqualToString:@"2"]) {
//        _infoView.image = [UIImage imageNamed:@"station"];
//    }
    _imgView.hidden = node.isLeaf;
    _infoView.hidden = node.isLeaf;
//    if (node.isLeaf) {
//        _imgView.alpha = 0;
//        _infoView.alpha = 0;
//    }
//    else {
//        _imgView.alpha = 1;
//        _infoView.alpha = 1;
//    }
    
   
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat indentationX = (_node.level-1)*leftMargin;
    
    _imgView.frame =CGRectMake(10+indentationX, (self.contentView.frame.size.height-20)/2, 20, 20);
   
    _infoView.frame =CGRectMake(_imgView.right+5, _imgView.top, 20, 20);
    
    _nodeLabel.frame = CGRectMake(_infoView.right, 0, self.contentView.width-25-_imgView.width-_infoView.width, self.contentView.height);
   
}















- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
