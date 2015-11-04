//
//  A3TopicVoiceView.h
//  BSBDJ
//
//  Created by mac on 15/11/4.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  A3Topic;
@interface A3TopicVoiceView : UIView

+ (instancetype)voiceView;

@property (nonatomic,strong)A3Topic *topic;
@end
