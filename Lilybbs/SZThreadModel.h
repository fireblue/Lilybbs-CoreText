//
//  SZThreadModel.h
//  Lilybbs
//
//  Created by Zongxuan Su on 12-11-22.
//  Copyright (c) 2012年 Nemoworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SZPostModel.h"

@interface SZThreadModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSMutableArray *threadPosts;
@property (nonatomic, strong) NSNumber *threadType;
@property (nonatomic, strong) NSString *threadBoard;
@property (nonatomic, strong) NSNumber *threadID;
@property (nonatomic, strong) NSString *threadStatus;
@property (nonatomic, strong) NSString *threadAuthorID;
@property (nonatomic, strong) NSString *threadAuthorNickname;
@property (nonatomic, strong) NSDate *threadDate;
@property (nonatomic, strong) NSString *threadURL;
@property (nonatomic, strong) NSString *threadTitle;
@property (nonatomic, strong) NSNumber *threadView;
@property (nonatomic, strong) NSNumber *threadReply;

@property (nonatomic, strong) NSString *previousPageURL;
@property (nonatomic, strong) NSString *nextPageURL;

@end
