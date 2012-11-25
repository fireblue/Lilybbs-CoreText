//
//  SZPostModel.m
//  Lilybbs
//
//  Created by Zongxuan Su on 12-11-22.
//  Copyright (c) 2012年 Nemoworks. All rights reserved.
//

#import "SZPostModel.h"

#define PostReplyURLKey @"postReplyURL"
#define PostAuthorIdKey @"postAuthorId"
#define PostAuthorNicknameKey @"postAuthorNickname"

#define PostFloorKey @"postFloor"
#define PostDateKey @"postDate"
#define PostContentKey @"postContent"
#define PostAuthorIpKey @"postAuthorIp"


@implementation SZPostModel

@synthesize postReplyURL;
@synthesize postAuthorId;
@synthesize postAuthorNickname;

@synthesize postFloor;
@synthesize postDate;
@synthesize postContent;
@synthesize postAuthorIp;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.postReplyURL = [aDecoder decodeObjectForKey:PostReplyURLKey];
        self.postAuthorId = [aDecoder decodeObjectForKey:PostAuthorIdKey];
        self.postAuthorNickname = [aDecoder decodeObjectForKey:PostAuthorNicknameKey];
        self.postFloor = [aDecoder decodeObjectForKey:PostFloorKey];
        self.postDate = [aDecoder decodeObjectForKey:PostDateKey];
        self.postContent = [aDecoder decodeObjectForKey:PostContentKey];
        self.postAuthorIp = [aDecoder decodeObjectForKey:PostAuthorIpKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.postReplyURL forKey:PostReplyURLKey];
    [aCoder encodeObject:self.postAuthorId forKey:PostAuthorIdKey];
    [aCoder encodeObject:self.postAuthorNickname forKey:PostAuthorNicknameKey];
    [aCoder encodeObject:self.postFloor forKey:PostFloorKey];
    [aCoder encodeObject:self.postDate forKey:PostDateKey];
    [aCoder encodeObject:self.postContent forKey:PostContentKey];
    [aCoder encodeObject:self.postAuthorIp forKey:PostAuthorIpKey];
}

- (id)copyWithZone:(NSZone *)zone
{
    SZPostModel *copy = [[SZPostModel alloc] init];
    copy.postReplyURL = [self.postReplyURL copy];
    copy.postAuthorId = [self.postAuthorId copy];
    copy.postAuthorNickname = [self.postAuthorNickname copy];
    copy.postFloor = [self.postFloor copy];
    copy.postDate = [self.postDate copy];
    copy.postContent = [self.postContent copy];
    copy.postAuthorIp = [self.postAuthorIp copy];
    return copy;
}


@end
