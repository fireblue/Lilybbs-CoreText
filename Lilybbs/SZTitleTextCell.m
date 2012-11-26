//
//  SZTitleTextCell.m
//  Lilybbs
//
//  Created by Zongxuan Su on 12-11-27.
//  Copyright (c) 2012年 Nemoworks. All rights reserved.
//

#import "SZTitleTextCell.h"

@implementation SZTitleTextCell

@synthesize titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [self.contentView addSubview:titleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [self requiredRowHeightInTableView:nil];
}

- (CGFloat)requiredRowHeightInTableView:(UITableView *)tableView
{
    
    titleLabel.frame = CGRectMake(5, 10, 310, 0);
    titleLabel.numberOfLines = 0;
    [titleLabel sizeToFit];
	return titleLabel.frame.size.height+20;
}


@end
