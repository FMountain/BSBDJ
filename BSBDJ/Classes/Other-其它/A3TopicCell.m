//
//  A3TopicCell.m
//  BSBDJ
//
//  Created by mac on 15/10/30.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3TopicCell.h"
#import "A3Topic.h"

@interface A3TopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel; //时间
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;    //分享
@property (weak, nonatomic) IBOutlet UIButton *commentButton; //评论
@end

@implementation A3TopicCell
//设置xib的背景图片
- (void)awakeFromNib
{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}
//调整框架
- (void)setFrame:(CGRect)frame
{
    frame.origin.y += A3Margin;
    frame.size.height -= A3Margin;
    [super setFrame:frame];
}

- (void)setTopic:(A3Topic *)topic
{
    _topic = topic;
    [self.profileImageView setHeaderWithURL:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.text_label.text =topic.text;
    self.createdAtLabel.text = topic.created_at;
    
    [self.dingButton setTitle:[NSString stringWithFormat:@"%zd",topic.ding] forState:UIControlStateNormal];
    [self.caiButton setTitle:[NSString stringWithFormat:@"%zd",topic.cai] forState:UIControlStateNormal];
    [self.repostButton setTitle:[NSString stringWithFormat:@"%zd",topic.repost] forState:UIControlStateNormal];
    [self.commentButton setTitle:[NSString stringWithFormat:@"%zd",topic.comment] forState:UIControlStateNormal];
}
@end
