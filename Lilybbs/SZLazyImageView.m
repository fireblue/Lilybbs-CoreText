//
//  SZLazyImageView.m
//  Lilybbs
//
//  Created by Zongxuan Su on 12-11-23.
//  Copyright (c) 2012年 Nemoworks. All rights reserved.
//

#import "SZLazyImageView.h"

@implementation SZLazyImageView

@synthesize button;
@synthesize parent;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchDown];
        [self addSubview:button];
    }
    return self;
}

- (void)notify
{
	CGFloat _fullWidth = self.image.size.width;
	CGFloat _fullHeight = self.image.size.height;
    CGFloat displayWidth = _fullWidth;
	CGFloat displayHeight = _fullHeight;
	
	if (displayWidth>0 && displayHeight>0) {
		displayWidth = MIN(_fullWidth, 300);
		displayHeight = displayWidth * (_fullHeight/_fullWidth);
	}
	
	if ([self.delegate respondsToSelector:@selector(lazyImageView:didChangeImageSize:)]) {
		[self.delegate lazyImageView:self didChangeImageSize:CGSizeMake(displayWidth, displayHeight)];
	}
}

    

- (void)buttonPressed
{
    NSLog(@"test");
}

@end
