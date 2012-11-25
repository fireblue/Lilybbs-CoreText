//
//  SZPostModel.h
//  Lilybbs
//
//  Created by Zongxuan Su on 12-11-22.
//  Copyright (c) 2012年 Nemoworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZPostModel : NSObject <NSCopying, NSCoding>

@property (nonatomic, strong) NSString *postReplyURL;
@property (nonatomic, strong) NSString *postAuthorId;
@property (nonatomic, strong) NSString *postAuthorNickname;

@property (nonatomic, strong) NSNumber *postFloor;
@property (nonatomic, strong) NSDate *postDate;
@property (nonatomic, strong) NSString *postContent;
@property (nonatomic, strong) NSString *postAuthorIp;

@end
