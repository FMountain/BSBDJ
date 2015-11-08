//
//  A3MeCell.m
//  BSBDJ
//
//  Created by mac on 15/11/8.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3MeCell.h"


@implementation A3MeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        self.textLabel.textColor = [UIColor darkGrayColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    
    self.imageView.height = self.contentView.height - A3Margin;
    self.imageView.width = self.imageView.height;
    self.imageView.centerY = self.contentView.height * 0.5;

    self.textLabel.x = self.imageView.right + A3Margin;
}


@end
