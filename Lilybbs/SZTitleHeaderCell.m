//
//  SZTitleTextCell.m
//  Lilybbs
//
//  Created by Zongxuan Su on 12-11-26.
//  Copyright (c) 2012年 Nemoworks. All rights reserved.
//

#import "SZTitleHeaderCell.h"

@implementation SZTitleHeaderCell

@synthesize titleColor, subTitleLabel, dateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        titleColor = [UIColor grayColor];
        
        headerLayer = [[CALayer alloc] init];
        [self.contentView.layer addSublayer:headerLayer];
        
        
        subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        subTitleLabel.textColor = [UIColor whiteColor];
        subTitleLabel.font = [UIFont systemFontOfSize:14];
        subTitleLabel.textAlignment = UITextAlignmentCenter;
        [self.contentView addSubview:subTitleLabel];
        
        dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.textColor = [UIColor grayColor];
        dateLabel.font = [UIFont systemFontOfSize:13];
        dateLabel.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:dateLabel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    headerLayer.frame = CGRectMake(0, 0, 320, 5);
    headerLayer.backgroundColor = titleColor.CGColor;
    
    subTitleLabel.frame = CGRectMake(5, 5, 100, 30);
    subTitleLabel.backgroundColor = titleColor;
    
    dateLabel.frame = CGRectMake(120, 5, 180, 30);
    
    
    
}

@end
