//
//  A3RecommenduserCell.m
//  BSBDJ
//
//  Created by mac on 15/11/7.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3RecommenduserCell.h"
#import "A3RecommendUser.h"

@interface A3RecommenduserCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation A3RecommenduserCell
- (void)setUser:(A3RecommendUser *)user
{
    _user = user;
    
    [self.headerImageView setHeaderWithURL:user.header];
    self.screenNameLabel.text = user.screen_name;
    
    if (user.fans_count >= 10000) {
        self.fansCountLabel.text = [NSString stringWithFormat:@"%.1f万人关注",user.fans_count / 10000.0];
    }else{
        self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    }
}
@end
