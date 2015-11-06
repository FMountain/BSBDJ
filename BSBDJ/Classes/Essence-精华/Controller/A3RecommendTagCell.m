//
//  A3RecommendTagCell.m
//  BSBDJ
//
//  Created by mac on 15/11/5.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3RecommendTagCell.h"
#import "A3RecommendTag.h"

@interface A3RecommendTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageListView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel; //订阅数
@end

@implementation A3RecommendTagCell

- (void)setRecommendTag:(A3RecommendTag *)recommendTag
{
    _recommendTag =recommendTag;
    //头像
    [self.imageListView setHeaderWithURL:recommendTag.image_list];
    
    //名字
    self.themeNameLabel.text = recommendTag.theme_name;
    
    //订阅数
    if(recommendTag.sub_number >= 1000){
        self.subNumberLabel.text = [NSString stringWithFormat:@"%.1f万人订阅",recommendTag.sub_number / 10000.0];
    }else {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%zd人订阅",recommendTag.sub_number];
    }
}

/**
 *  重写setFrame 作用: 监听设置cell的frame过程
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height -=1;
    [super setFrame:frame];
}
@end
