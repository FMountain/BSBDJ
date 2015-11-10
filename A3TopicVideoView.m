//
//  A3TopicVideoView.m
//  BSBDJ
//
//  Created by mac on 15/11/4.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3TopicVideoView.h"
#import "A3Topic.h"
#import <UIImageView+WebCache.h>
#import <MediaPlayer/MediaPlayer.h>

@interface A3TopicVideoView ()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
- (IBAction)videoClick:(UIButton *)sender;

/** 播放器 */
@property (nonatomic, strong) MPMoviePlayerController *player;


@end

@implementation A3TopicVideoView

- (void)setTopic:(A3Topic *)topic
{
    [super setTopic:topic];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}
- (IBAction)videoClick:(UIButton *)sender {
    
    //播放
    [self.player play];
    
    //添加通知
    [self addNotification];
    
//    //获取缩略图
//    [self thumbnailImageRequest];
}

#pragma mark - lazy
- (MPMoviePlayerController *)player
{
    if (_player == nil) {
        // 1.创建播放器
        _player = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:self.topic.videouri]];
        
        // 2.给播放器内部的View设置frame
        _player.view.frame =CGRectMake(0, 0,self.width, self.height);
        
        // 3.添加到控制器View中
        [self addSubview:_player.view];
        
        // 4.设置控制面板的显示
        _player.controlStyle = MPMovieControlStyleEmbedded;
    }
    return _player;
}

///**
// *  获取视频缩略图
// */
//-(void)thumbnailImageRequest{
//    //获取13.0s、21.5s的缩略图
//    [self.player requestThumbnailImagesAtTimes:@[@13.0,@21.5] timeOption:MPMovieTimeOptionNearestKeyFrame];
//}

#pragma mark - 控制器通知
/**
 *  添加通知监控媒体播放控制状态
 */
- (void)addNotification{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.player];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.player];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerThumbnailRequestFinished:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:self.player];
}
/**
 *  播放器状态改变,注意播放完成时的状态是暂停
 *  @param notification 通知对象
 */
- (void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.player.playbackState) {
        case MPMoviePlaybackStatePlaying:
            A3Log(@"正在播放....");
            break;
        case MPMoviePlaybackStatePaused:
            A3Log(@"播放暂停.");
            break;
        default:
            A3Log(@"播放状态%li",self.player.playbackState);
            break;
    }
}
/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    NSLog(@"播放完成.%li",self.player.playbackState);
}

/**
 *  缩略图请求完成,此方法每次截图成功都会调用一次
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerThumbnailRequestFinished:(NSNotification *)notification{
    NSLog(@"视频截图完成.");
    UIImage *image=notification.userInfo[MPMoviePlayerThumbnailImageKey];
    //保存图片到相册(首次调用会请求用户获得访问相册权限)
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

@end
