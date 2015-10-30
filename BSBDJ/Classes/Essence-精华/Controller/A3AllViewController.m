//
//  A3AllViewController.m
//  BSBDJ
//
//  Created by mac on 15/10/30.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3AllViewController.h"

@interface A3AllViewController ()

@end

@implementation A3AllViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //内边距
    self.tableView.contentInset = UIEdgeInsetsMake(A3NavBarBottom + A3TitlesViewH, 0, A3TabBarH, 0 );
    
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

#pragma mark - table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = A3RandomColor;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ -- %zd",self.title,indexPath.row];
    return cell;
}
@end
