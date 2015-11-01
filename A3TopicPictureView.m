//
//  A3TopicPictureView.m
//  BSBDJ
//
//  Created by mac on 15/11/1.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3TopicPictureView.h"
#import "A3Topic.h"
#import <UIImageView+WebCache.h>

@interface A3TopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@end

@implementation A3TopicPictureView

+ (instancetype)pictureView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)awakeFromNib
{
    //去除默认的autoresizingMask设置
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(A3Topic *)topic
{
    _topic = topic;
    //显示图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    //是否为gif
    self.gifView.hidden = !topic.is_gif;
    //查看大图
    self.seeBigButton.hidden = !topic.isBigPicture;
    if (topic.isBigPicture) {
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    }else{
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
}
@end
