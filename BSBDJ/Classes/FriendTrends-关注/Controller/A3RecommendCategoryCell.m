//
//  A3RecommendCategoryCell.m
//  BSBDJ
//
//  Created by mac on 15/11/7.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3RecommendCategoryCell.h"
#import "A3RecommendCategory.h"

@interface A3RecommendCategoryCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;
@end

@implementation A3RecommendCategoryCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected) { //选中
        self.nameLabel.textColor = [UIColor redColor];
        self.selectedIndicator.hidden = NO;
    }else{//取消选中.
        self.nameLabel.textColor = [UIColor darkGrayColor];
        self.selectedIndicator.hidden = YES;
    }
}

- (void)setCategory:(A3RecommendCategory *)category
{
    _category = category;
    
    self.nameLabel.text = category.name;
}
@end
