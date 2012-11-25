//
//  SZAttributedTextCell.m
//  Lilybbs
//
//  Created by Zongxuan Su on 12-11-24.
//  Copyright (c) 2012年 Nemoworks. All rights reserved.
//

#import "SZAttributedTextCell.h"

#define OTHER_LABEL_HEIGHT 60

@implementation SZAttributedTextCell

@synthesize authorLabel, dateLabel, ipLabel;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier accessoryType:(UITableViewCellAccessoryType)accessoryType
{
    self = [super initWithReuseIdentifier:reuseIdentifier accessoryType:accessoryType];
    if (self) {
        authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        [self.contentView addSubview:authorLabel];
        
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 320, 20)];
        [self.contentView addSubview:dateLabel];
        
        ipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:ipLabel];
    }
    return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGFloat neededContentHeight = [self requiredRowHeightInTableView:(UITableView *)self.superview]-OTHER_LABEL_HEIGHT;
	
	// after the first call here the content view size is correct
	CGRect frame = CGRectMake(0, 40, self.contentView.bounds.size.width, neededContentHeight);
	
	// only change frame if width has changed to avoid extra layouting
	if (self.attributedTextContextView.frame.origin.y != 40)
	{
		self.attributedTextContextView.frame = frame;
	}
    
    ipLabel.frame = CGRectMake(0, 40+neededContentHeight, 320, 20);
}

- (CGFloat)requiredRowHeightInTableView:(UITableView *)tableView
{
	return [super requiredRowHeightInTableView:tableView]+OTHER_LABEL_HEIGHT;
}

@end
