//
//  SZAttributedTextCell.m
//  Lilybbs
//
//  Created by Zongxuan Su on 12-11-24.
//  Copyright (c) 2012年 Nemoworks. All rights reserved.
//

#import "SZAttributedTextCell.h"


@implementation SZAttributedTextCell

@synthesize indexPath;
@synthesize authorLabel, dateLabel, ipLabel;
@synthesize date;

+ (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [formatter setDateFormat:@"MMM dd日  HH:mm:ss yyyy"];
    });
    return formatter;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier accessoryType:(UITableViewCellAccessoryType)accessoryType
{
    self = [super initWithReuseIdentifier:reuseIdentifier accessoryType:accessoryType];
    if (self) {
        authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 310, 20)];
        authorLabel.backgroundColor = [UIColor clearColor];
        authorLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        [self.contentView addSubview:authorLabel];
        
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, 310, 20)];
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:dateLabel];
        
        ipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        ipLabel.backgroundColor = [UIColor clearColor];
        ipLabel.textColor = [UIColor grayColor];
        ipLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:ipLabel];
    }
    return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGFloat neededContentHeight = [self requiredRowHeightInTableView:(UITableView *)self.superview]-OTHER_LABEL_HEIGHT;
	
	// after the first call here the content view size is correct
	CGRect frame = CGRectMake(0, 50, self.contentView.bounds.size.width, neededContentHeight);
	
	// only change frame if width has changed to avoid extra layouting
	self.attributedTextContextView.frame = frame;
    
    ipLabel.frame = CGRectMake(5, 60+neededContentHeight, 320, 20);
}

- (CGFloat)requiredRowHeightInTableView:(UITableView *)tableView
{
	return [super requiredRowHeightInTableView:tableView]+OTHER_LABEL_HEIGHT;
}

@end
