//
//  SZThreadModel.m
//  Lilybbs
//
//  Created by Zongxuan Su on 12-11-22.
//  Copyright (c) 2012年 Nemoworks. All rights reserved.
//

#import "SZThreadModel.h"

#define ThreadPostsKey @"threadPosts"
#define ThreadTypeKey @"threadType"
#define ThreadBoardKey @"threadBoard"
#define ThreadIDKey @"threadID"
#define ThreadStatusKey @"threadStatus"
#define ThreadAuthorIDKey @"threadAuthorID"
#define ThreadAuthorNicknameKey @"threadAuthorNickname"
#define ThreadDateKey @"threadDate"
#define ThreadURLKey @"threadURL"
#define ThreadTitleKey @"threadTitle"
#define ThreadViewKey @"threadView"
#define ThreadReplyKey @"threadReply"

#define PreviousPageURLKey @"previousPageURL"
#define NextPageURLKey @"nextPageURL"


@implementation SZThreadModel

@synthesize threadPosts;
@synthesize threadType;
@synthesize threadBoard;
@synthesize threadID;
@synthesize threadStatus;
@synthesize threadAuthorID;
@synthesize threadAuthorNickname;
@synthesize threadDate;
@synthesize threadURL;
@synthesize threadTitle;
@synthesize threadView;
@synthesize threadReply;

@synthesize previousPageURL;
@synthesize nextPageURL;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.threadPosts = [aDecoder decodeObjectForKey:ThreadPostsKey];
        self.threadType = [aDecoder decodeObjectForKey:ThreadTypeKey];
        self.threadBoard = [aDecoder decodeObjectForKey:ThreadBoardKey];
        self.threadID = [aDecoder decodeObjectForKey:ThreadIDKey];
        self.threadStatus = [aDecoder decodeObjectForKey:ThreadStatusKey];
        self.threadAuthorID = [aDecoder decodeObjectForKey:ThreadAuthorIDKey];
        self.threadAuthorNickname = [aDecoder decodeObjectForKey:ThreadAuthorNicknameKey];
        self.threadDate = [aDecoder decodeObjectForKey:ThreadDateKey];
        self.threadURL = [aDecoder decodeObjectForKey:ThreadURLKey];
        self.threadTitle = [aDecoder decodeObjectForKey:ThreadTitleKey];
        self.threadView = [aDecoder decodeObjectForKey:ThreadViewKey];
        self.threadReply = [aDecoder decodeObjectForKey:ThreadReplyKey];
        
        self.previousPageURL = [aDecoder decodeObjectForKey:PreviousPageURLKey];
        self.nextPageURL = [aDecoder decodeObjectForKey:NextPageURLKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.threadPosts forKey:ThreadPostsKey];
    [aCoder encodeObject:self.threadType forKey:ThreadTypeKey];
    [aCoder encodeObject:self.threadBoard forKey:ThreadBoardKey];
    [aCoder encodeObject:self.threadID forKey:ThreadIDKey];
    [aCoder encodeObject:self.threadStatus forKey:ThreadStatusKey];
    [aCoder encodeObject:self.threadAuthorID forKey:ThreadAuthorIDKey];
    [aCoder encodeObject:self.threadAuthorNickname forKey:ThreadAuthorNicknameKey];
    [aCoder encodeObject:self.threadDate forKey:ThreadDateKey];
    [aCoder encodeObject:self.threadURL forKey:ThreadURLKey];
    [aCoder encodeObject:self.threadTitle forKey:ThreadTitleKey];
    [aCoder encodeObject:self.threadView forKey:ThreadViewKey];
    [aCoder encodeObject:self.threadReply forKey:ThreadReplyKey];
    
    [aCoder encodeObject:self.previousPageURL forKey:PreviousPageURLKey];
    [aCoder encodeObject:self.nextPageURL forKey:NextPageURLKey];
}

- (id)copyWithZone:(NSZone *)zone
{
    SZThreadModel *copy = [[SZThreadModel alloc] init];
    copy.threadPosts = [self.threadPosts copy];
    copy.threadType = [self.threadType copy];
    copy.threadBoard = [self.threadBoard copy];
    copy.threadID = [self.threadID copy];
    copy.threadStatus = [self.threadStatus copy];
    copy.threadAuthorID = [self.threadAuthorID copy];
    copy.threadAuthorNickname = [self.threadAuthorNickname copy];
    copy.threadDate = [self.threadDate copy];
    copy.threadURL = [self.threadURL copy];
    copy.threadTitle = [self.threadTitle copy];
    copy.threadView = [self.threadView copy];
    copy.threadReply = [self.threadReply copy];
    
    copy.previousPageURL = [self.previousPageURL copy];
    copy.nextPageURL = [self.nextPageURL copy];
    return copy;
}

@end
