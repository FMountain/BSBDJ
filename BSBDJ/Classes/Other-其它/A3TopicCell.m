//
//  A3TopicCell.m
//  BSBDJ
//
//  Created by mac on 15/10/30.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3TopicCell.h"
#import "A3Topic.h"
#import "A3User.h"
#import "A3Comment.h"
#import "A3TopicPictureView.h"
#import "A3TopicVideoView.h"
#import "A3TopicVoiceView.h"

@interface A3TopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel; //时间
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;    //分享
@property (weak, nonatomic) IBOutlet UIButton *commentButton; //评论
/** 最热评论-整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;

/** 中间控件 - 图片控件 */
@property (nonatomic, weak) A3TopicPictureView *pictureView;
/** 声音控件 */
@property (nonatomic, weak) A3TopicVoiceView *voiceView;
/** 视频控件 */
@property (nonatomic, weak) A3TopicVideoView *videoView;
@end

@implementation A3TopicCell
#pragma mark - lazy
- (A3TopicPictureView *)pictureView
{
    if (!_pictureView) {
        A3TopicPictureView *pictureView = [A3TopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (A3TopicVoiceView *)voiceView
{
    if (!_voiceView) {
        A3TopicVoiceView  *voiceView = [A3TopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}


#pragma mark - lazy
- (A3TopicVideoView *)videoView
{
    if (!_videoView) {
        A3TopicVideoView  *videoView = [A3TopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}
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
/*设置按钮的数字
*  @param button 按钮
*  @param number 数字
*  @param title  数字为0时显示的文字
 */
- (void)setupButton:(UIButton *)button number:(NSInteger)number title:(NSString *)title
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万" ,number /10000.0] forState:UIControlStateNormal];
    } else if (number == 0){
        [button setTitle:title forState:UIControlStateNormal];
    }else {
        [button setTitle: [NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }
}
/**
 *  这个方法调用非常频繁
 */
- (void)setTopic:(A3Topic *)topic
{
    _topic = topic;
    [self.profileImageView setHeaderWithURL:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.text_label.text =topic.text;
    self.createdAtLabel.text = topic.created_at;
    
    //设置底部工具条的数字
    [self setupButton:self.dingButton number:topic.ding title:@"顶"];
    [self setupButton:self.caiButton number:topic.cai title:@"踩"];
    [self setupButton:self.repostButton number:topic.repost title:@"分享"];
    [self setupButton:self.commentButton number:topic.comment title:@"评论"];
    
    //最热评论
    if(topic.top_cmt)  //如果有最热评论
    {
        self.topCmtView.hidden = NO;//不隐藏
        //内容
        NSString *content = topic.top_cmt.content;
        //用户名
        NSString *username = topic.top_cmt.user.username;
        
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@",username,content];
    }else {
        self.topCmtView.hidden = YES;
    }
    //中间的具体内容
    if(topic.type == A3TopicTypePicture){ //图片
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        
        //往中间添加图片控件
        self.pictureView.hidden = NO;
        self.pictureView.frame = topic.centerViewFrame;
        self.pictureView.topic = topic; //数据
    } else if (topic.type == A3TopicTypeVoice){ //声音
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        
        self.voiceView.hidden = NO;
        self.voiceView.frame = topic.centerViewFrame;
        self.voiceView.topic = topic;
    }else if (topic.type == A3TopicTypeVideo){ //视频
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        
        self.videoView.hidden = NO;
        self.videoView.frame = topic.centerViewFrame;
        self.videoView.topic = topic;
    }else { //文字
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }
}
- (IBAction)moreClick
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //添加按钮
    [alert addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        A3Log(@"点击了[收藏]");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        A3Log(@"点击了[举报]");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        A3Log(@"点击了[取消]");
    }]];
    
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}
@end
