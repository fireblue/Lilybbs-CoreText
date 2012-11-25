//
//  SZAttributedTextCell.h
//  Lilybbs
//
//  Created by Zongxuan Su on 12-11-24.
//  Copyright (c) 2012年 Nemoworks. All rights reserved.
//

#import "DTCoreText.h"

@interface SZAttributedTextCell : DTAttributedTextCell

@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *ipLabel;

@end
