//
//  DTTestViewController.h
//  Lilybbs
//
//  Created by Zongxuan Su on 12-11-22.
//  Copyright (c) 2012年 Nemoworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTAttributedTextView.h"
#import "DTLazyImageView.h"

@interface DTTestViewController : UIViewController <DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate>
{
    DTAttributedTextView *_textView;
}


@property (nonatomic, strong) NSURL *lastActionLink;

@end
