//
//  SZLazyImageView.h
//  Lilybbs
//
//  Created by Zongxuan Su on 12-11-23.
//  Copyright (c) 2012年 Nemoworks. All rights reserved.
//

#import "DTCoreText.h"

@class DTAttributedTextContentView;

@interface SZLazyImageView : DTLazyImageView

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, weak) DTAttributedTextContentView *parent;

@end
