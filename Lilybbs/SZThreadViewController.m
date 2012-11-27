//
//  SZThreadViewController.m
//  Lilybbs
//
//  Created by Zongxuan Su on 12-11-22.
//  Copyright (c) 2012年 Nemoworks. All rights reserved.
//

#import "SZThreadViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SZAttributedTextCell.h"

#import "SCGIFImageView.h"
#import "SZTitleHeaderCell.h"
#import "SZTitleTextCell.h"

@interface SZThreadViewController ()

@property (nonatomic, strong) NSMutableSet *mediaPlayers;

@end

@implementation SZThreadViewController

@synthesize mediaPlayers;
@synthesize lastActionLink;

- (id)init
{
    self = [super init];
    if (self) {
        [self loadTestFile];
    }
    return self;
}

- (void)loadTestFile
{
    _thread = [[SZThreadModel alloc] init];
    NSString *testPath = [[NSBundle mainBundle] pathForResource:@"threadTest" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:testPath];
    _thread.threadTitle = [dict objectForKey:@"title"];
    NSMutableArray *posts = [[NSMutableArray alloc] init];
    NSArray *dictPosts = [dict objectForKey:@"posts"];
    for (NSDictionary *dictPost in dictPosts) {
        SZPostModel *post = [[SZPostModel alloc] init];
        post.postAuthorId = [dictPost objectForKey:@"authorid"];
        post.postAuthorNickname = [dictPost objectForKey:@"authornick"];
        post.postDate = [dictPost objectForKey:@"date"];
        post.postContent = [dictPost objectForKey:@"content"];
        post.postAuthorIp = [dictPost objectForKey:@"ip"];
        [posts addObject:post];
    }
    _thread.threadPosts = posts;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.title = @"详细信息";
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [_thread.threadPosts count]+2;
}

- (void)configureCell:(SZAttributedTextCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
	SZPostModel *snippet = [_thread.threadPosts objectAtIndex:indexPath.row-2];
	
	NSString *html = snippet.postContent;
	
	[cell setHTMLString:html];
	
	cell.attributedTextContextView.shouldDrawImages = YES;
    cell.attributedTextContextView.delegate = self;
    
    cell.authorLabel.text = [NSString stringWithFormat:@"%@(%@)", snippet.postAuthorId, snippet.postAuthorNickname];
    cell.dateLabel.text = [[SZAttributedTextCell dateFormatter] stringFromDate:snippet.postDate];
    cell.ipLabel.text = snippet.postAuthorIp;
    
}

- (SZAttributedTextCell *)tableView:(UITableView *)tableView preparedCellForIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"cellIdentifier";
    
	if (!_cellCache)
	{
		_cellCache = [[NSCache alloc] init];
	}
	
	// workaround for iOS 5 bug
	NSString *key = [NSString stringWithFormat:@"%d-%d", indexPath.section, indexPath.row];
	
	SZAttributedTextCell *cell = [_cellCache objectForKey:key];
    
	if (!cell)
	{
		// reuse does not work for variable height
		//cell = (SZAttributedTextCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
		if (!cell)
		{
			cell = [[SZAttributedTextCell alloc] initWithReuseIdentifier:cellIdentifier accessoryType:UITableViewCellAccessoryDisclosureIndicator];
		}
		
		// cache it
		[_cellCache setObject:cell forKey:key];
	}
	
	[self configureCell:cell forIndexPath:indexPath];
	
	return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView prepareTitleCellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *titleCellIdentifier = @"TitleCellIdentifier";
    SZTitleTextCell *cell = [self.tableView dequeueReusableCellWithIdentifier:titleCellIdentifier];
    if (nil == cell) {
        cell = [[SZTitleTextCell alloc] initWithStyle:self.tableView.style reuseIdentifier:titleCellIdentifier];
    }
    cell.titleLabel.text = _thread.threadTitle;
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView prepareTitleHeaderCellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *titleCellIdentifier = @"TitleHeaderCellIdentifier";
    SZTitleHeaderCell *cell = [self.tableView dequeueReusableCellWithIdentifier:titleCellIdentifier];
    if (nil == cell) {
        cell = [[SZTitleHeaderCell alloc] initWithStyle:self.tableView.style reuseIdentifier:titleCellIdentifier];
    }
    cell.titleColor = [UIColor colorWithRed:46.0f/255.0f green:168.0f/255.0f blue:228.0f/255.0f alpha:1];
    cell.subTitleLabel.text = @"Photography";
    cell.dateLabel.text = @"11月22日  22:31:09  2012";
    return cell;
}

// disable this method to get static height = better performance
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 40;
            break;
        case 1:
        {
            SZTitleTextCell *cell = (SZTitleTextCell *)[self tableView:tableView prepareTitleCellForIndexPath:indexPath];
            return [cell requiredRowHeightInTableView:tableView];
        }
            break;
        default:
        {
            SZAttributedTextCell *cell = (SZAttributedTextCell *)[self tableView:tableView preparedCellForIndexPath:indexPath];
            
            return [cell requiredRowHeightInTableView:tableView];
        }
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    switch (indexPath.row) {
        case 0:
            cell = [self tableView:tableView prepareTitleHeaderCellForIndexPath:indexPath];
            break;
        case 1:
            cell = [self tableView:tableView prepareTitleCellForIndexPath:indexPath];
            break;
        default:
            cell = [self tableView:tableView preparedCellForIndexPath:indexPath];
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




#pragma mark Custom Views on Text

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttributedString:(NSAttributedString *)string frame:(CGRect)frame
{
	NSDictionary *attributes = [string attributesAtIndex:0 effectiveRange:NULL];
	
	NSURL *URL = [attributes objectForKey:DTLinkAttribute];
	NSString *identifier = [attributes objectForKey:DTGUIDAttribute];
	
	
	DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:frame];
	button.URL = URL;
	button.minimumHitSize = CGSizeMake(25, 25); // adjusts it's bounds so that button is always large enough
	button.GUID = identifier;
	
	// we draw the contents ourselves
	button.attributedString = string;
	
	// make a version with different text color
	NSMutableAttributedString *highlightedString = [string mutableCopy];
	
	NSRange range = NSMakeRange(0, highlightedString.length);
	
	NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:(__bridge id)[UIColor redColor].CGColor forKey:(id)kCTForegroundColorAttributeName];
	
	
	[highlightedString addAttributes:highlightedAttributes range:range];
	
	button.highlightedAttributedString = highlightedString;
	
	// use normal push action for opening URL
	[button addTarget:self action:@selector(linkPushed:) forControlEvents:UIControlEventTouchUpInside];
	
	// demonstrate combination with long press
	UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(linkLongPressed:)];
	[button addGestureRecognizer:longPress];
	
	return button;
}

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame
{
	if (attachment.contentType == DTTextAttachmentTypeVideoURL)
	{
		NSURL *url = (id)attachment.contentURL;
		
		// we could customize the view that shows before playback starts
		UIView *grayView = [[UIView alloc] initWithFrame:frame];
		grayView.backgroundColor = [DTColor blackColor];
		
		// find a player for this URL if we already got one
		MPMoviePlayerController *player = nil;
		for (player in self.mediaPlayers)
		{
			if ([player.contentURL isEqual:url])
			{
				break;
			}
		}
		
		if (!player)
		{
			player = [[MPMoviePlayerController alloc] initWithContentURL:url];
			[self.mediaPlayers addObject:player];
		}
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_4_2
		NSString *airplayAttr = [attachment.attributes objectForKey:@"x-webkit-airplay"];
		if ([airplayAttr isEqualToString:@"allow"])
		{
			if ([player respondsToSelector:@selector(setAllowsAirPlay:)])
			{
				player.allowsAirPlay = YES;
			}
		}
#endif
		
		NSString *controlsAttr = [attachment.attributes objectForKey:@"controls"];
		if (controlsAttr)
		{
			player.controlStyle = MPMovieControlStyleEmbedded;
		}
		else
		{
			player.controlStyle = MPMovieControlStyleNone;
		}
		
		NSString *loopAttr = [attachment.attributes objectForKey:@"loop"];
		if (loopAttr)
		{
			player.repeatMode = MPMovieRepeatModeOne;
		}
		else
		{
			player.repeatMode = MPMovieRepeatModeNone;
		}
		
		NSString *autoplayAttr = [attachment.attributes objectForKey:@"autoplay"];
		if (autoplayAttr)
		{
			player.shouldAutoplay = YES;
		}
		else
		{
			player.shouldAutoplay = NO;
		}
		
		[player prepareToPlay];
		
		player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		player.view.frame = grayView.bounds;
		[grayView addSubview:player.view];
		
		return grayView;
	}
	else if (attachment.contentType == DTTextAttachmentTypeImage)
	{
        if ([attachment.contentURL isFileURL] && [attachment.contentURL.absoluteString hasSuffix:@".gif"]) {
            
            // if the attachment has a hyperlinkURL then this is currently ignored
            SCGIFImageView *imageView = [[SCGIFImageView alloc] initWithGIFData:[NSData dataWithContentsOfURL:attachment.contentURL]];
            return imageView;
            
        }
        else {
            // if the attachment has a hyperlinkURL then this is currently ignored
            SZLazyImageButton *imageView = [[SZLazyImageButton alloc] initWithFrame:frame];
            imageView.delegate = self;
            imageView.parent = attributedTextContentView;
            if (attachment.contents)
            {
                imageView.image = attachment.contents;
            }
            
            // url for deferred loading
            imageView.url = attachment.contentURL;
            
            [imageView setImageWithURL:attachment.contentURL placeholderImage:[UIImage imageNamed:@"Default"]];
            
            [imageView addTarget:self action:@selector(imageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            return imageView;
        }
	}
	else if (attachment.contentType == DTTextAttachmentTypeIframe)
	{
		frame.origin.x += 50;
		DTWebVideoView *videoView = [[DTWebVideoView alloc] initWithFrame:frame];
		videoView.attachment = attachment;
		
		return videoView;
	}
	else if (attachment.contentType == DTTextAttachmentTypeObject)
	{
		// somecolorparameter has a HTML color
		UIColor *someColor = [UIColor colorWithHTMLName:[attachment.attributes objectForKey:@"somecolorparameter"]];
		
		UIView *someView = [[UIView alloc] initWithFrame:frame];
		someView.backgroundColor = someColor;
		someView.layer.borderWidth = 1;
		someView.layer.borderColor = [UIColor blackColor].CGColor;
		
		return someView;
	}
	
	return nil;
}

- (BOOL)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView shouldDrawBackgroundForTextBlock:(DTTextBlock *)textBlock frame:(CGRect)frame context:(CGContextRef)context forLayoutFrame:(DTCoreTextLayoutFrame *)layoutFrame
{
	UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:10];
    
	CGColorRef color = [textBlock.backgroundColor CGColor];
	if (color)
	{
		CGContextSetFillColorWithColor(context, color);
		CGContextAddPath(context, [roundedRect CGPath]);
		CGContextFillPath(context);
		
		CGContextAddPath(context, [roundedRect CGPath]);
		CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
		CGContextStrokePath(context);
		return NO;
	}
	
	return YES; // draw standard background
}


#pragma mark Actions

- (void)imageButtonPressed:(UIButton *)sender
{
    NSLog(@"image pressed");
}

- (void)linkPushed:(DTLinkButton *)button
{
	NSURL *URL = button.URL;
	
	if ([[UIApplication sharedApplication] canOpenURL:[URL absoluteURL]])
	{
		[[UIApplication sharedApplication] openURL:[URL absoluteURL]];
	}
	else
	{
		if (![URL host] && ![URL path])
		{
            
			// possibly a local anchor link
			NSString *fragment = [URL fragment];
			
			if (fragment)
			{
				//[_textView scrollToAnchorNamed:fragment animated:NO];
			}
		}
	}
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex != actionSheet.cancelButtonIndex)
	{
		[[UIApplication sharedApplication] openURL:[self.lastActionLink absoluteURL]];
	}
}

- (void)linkLongPressed:(UILongPressGestureRecognizer *)gesture
{
	if (gesture.state == UIGestureRecognizerStateBegan)
	{
		DTLinkButton *button = (id)[gesture view];
		button.highlighted = NO;
		self.lastActionLink = button.URL;
		
		if ([[UIApplication sharedApplication] canOpenURL:[button.URL absoluteURL]])
		{
			UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:[[button.URL absoluteURL] description] delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Open in Safari", nil];
			[action showFromRect:button.frame inView:button.superview animated:YES];
		}
	}
}


#pragma mark DTLazyImageViewDelegate

- (void)lazyImageView:(SZLazyImageView *)lazyImageButton didChangeImageSize:(CGSize)size
{
	NSURL *url = lazyImageButton.url;
	CGSize imageSize = size;
	
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"contentURL == %@", url];
	
	// update all attachments that matchin this URL (possibly multiple images with same size)
	for (DTTextAttachment *oneAttachment in [lazyImageButton.parent.layoutFrame textAttachmentsWithPredicate:pred])
	{
		oneAttachment.originalSize = imageSize;
		
		if (!CGSizeEqualToSize(imageSize, oneAttachment.displaySize))
		{
			oneAttachment.displaySize = imageSize;
		}
	}
	// redo layout
	// here we're layouting the entire string, might be more efficient to only relayout the paragraphs that contain these attachments
	[lazyImageButton.parent relayoutText];
    
    [self.tableView reloadData];
}

- (void)lazyImageButton:(SZLazyImageButton *)lazyImageButton didChangeImageSize:(CGSize)size
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = lazyImageButton.url;
        CGSize imageSize = size;
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"contentURL == %@", url];
        
        // update all attachments that matchin this URL (possibly multiple images with same size)
        for (DTTextAttachment *oneAttachment in [lazyImageButton.parent.layoutFrame textAttachmentsWithPredicate:pred])
        {
            oneAttachment.originalSize = imageSize;
            
            if (!CGSizeEqualToSize(imageSize, oneAttachment.displaySize))
            {
                oneAttachment.displaySize = imageSize;
            }
        }
    });
	// redo layout
	// here we're layouting the entire string, might be more efficient to only relayout the paragraphs that contain these attachments
	[lazyImageButton.parent relayoutText];
    
    [self.tableView reloadData];
}

#pragma mark Properties

- (NSMutableSet *)mediaPlayers
{
	if (!mediaPlayers)
	{
		mediaPlayers = [[NSMutableSet alloc] init];
	}
	
	return mediaPlayers;
}


@end
