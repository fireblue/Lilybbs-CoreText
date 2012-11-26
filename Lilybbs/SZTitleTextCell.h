//
//  SZTitleTextCell.h
//  Lilybbs
//
//  Created by Zongxuan Su on 12-11-27.
//  Copyright (c) 2012年 Nemoworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZTitleTextCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

- (CGFloat)requiredRowHeightInTableView:(UITableView *)tableView;

@end
