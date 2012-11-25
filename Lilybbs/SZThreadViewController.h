//
//  SZThreadViewController.h
//  Lilybbs
//
//  Created by Zongxuan Su on 12-11-22.
//  Copyright (c) 2012年 Nemoworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZThreadModel.h"
#import "DTAttributedTextView.h"
#import "SZLazyImageButton.h"
#import "SZLazyImageView.h"

@interface SZThreadViewController : UITableViewController<DTAttributedTextContentViewDelegate, SZLazyImageButtonDelegate>
{
    SZThreadModel *_thread;
    NSCache *_cellCache;
}

@property (nonatomic, strong) NSURL *lastActionLink;

@end
