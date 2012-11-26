//
//  SZTitleTextCell.h
//  Lilybbs
//
//  Created by Zongxuan Su on 12-11-26.
//  Copyright (c) 2012年 Nemoworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SZTitleHeaderCell : UITableViewCell
{
    CALayer *headerLayer;
}

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@end
