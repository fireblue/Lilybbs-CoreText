// UIImageView+AFNetworking.m
//
// Copyright (c) 2011 Gowalla (http://gowalla.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED
#import "SZLazyImageButton.h"

static char kAFImageRequestOperationObjectKey;

@interface SZLazyImageButton ()
@property (nonatomic, strong) AFImageRequestOperation *af_imageRequestOperation;
@end

@implementation SZLazyImageButton

@synthesize af_imageRequestOperation;

@synthesize delegate;
@synthesize image;
@synthesize parent;
@synthesize url;

- (void)af_setImageRequestOperation:(AFImageRequestOperation *)imageRequestOperation {
    objc_setAssociatedObject(self, &kAFImageRequestOperationObjectKey, imageRequestOperation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSOperationQueue *)af_sharedImageRequestOperationQueue {
    static NSOperationQueue *_af_imageRequestOperationQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _af_imageRequestOperationQueue = [[NSOperationQueue alloc] init];
        [_af_imageRequestOperationQueue setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
    });
    
    return _af_imageRequestOperationQueue;
}

#pragma mark -

- (void)setImageWithURL:(NSURL *)url {
    [self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholderImage
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPShouldHandleCookies:NO];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    [self setImageWithURLRequest:request placeholderImage:placeholderImage success:nil failure:nil];
}

- (void)setImageWithURLRequest:(NSURLRequest *)urlRequest
              placeholderImage:(UIImage *)placeholderImage
                       success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                       failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure
{
    [self cancelImageRequestOperation];
    
    UIImage *cachedImage = nil;//[[[self class] af_sharedImageCache] cachedImageForRequest:urlRequest];
    if (cachedImage) {
        [self setBackgroundImage:cachedImage forState:UIControlStateNormal];
        [self setBackgroundImage:cachedImage forState:UIControlStateHighlighted];
        [self setBackgroundImage:cachedImage forState:UIControlStateSelected];
        self.af_imageRequestOperation = nil;
        
        if (success) {
            success(nil, nil, cachedImage);
        }
    } else {
        
        [self setBackgroundImage:placeholderImage forState:UIControlStateNormal];
        [self setBackgroundImage:placeholderImage forState:UIControlStateHighlighted];
        [self setBackgroundImage:placeholderImage forState:UIControlStateSelected];
        
        AFImageRequestOperation *requestOperation = [[AFImageRequestOperation alloc] initWithRequest:urlRequest];
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([[urlRequest URL] isEqual:[[self.af_imageRequestOperation request] URL]]) {
                if (success) {
                    success(operation.request, operation.response, responseObject);
                } else {
                    
                    [self setBackgroundImage:responseObject forState:UIControlStateNormal];
                    [self setBackgroundImage:responseObject forState:UIControlStateHighlighted];
                    [self setBackgroundImage:responseObject forState:UIControlStateSelected];
                    self.image = responseObject;
                    [self notify];
                    
                }
                
                self.af_imageRequestOperation = nil;
            }
            
            //[[[self class] af_sharedImageCache] cacheImage:responseObject forRequest:urlRequest];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if ([[urlRequest URL] isEqual:[[self.af_imageRequestOperation request] URL]]) {
                if (failure) {
                    failure(operation.request, operation.response, error);
                }
                
                self.af_imageRequestOperation = nil;
            }
        }];
        
        self.af_imageRequestOperation = requestOperation;
        
        [[[self class] af_sharedImageRequestOperationQueue] addOperation:self.af_imageRequestOperation];
    }
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
	
	if ([self.delegate respondsToSelector:@selector(lazyImageButton:didChangeImageSize:)]) {
		[self.delegate lazyImageButton:self didChangeImageSize:CGSizeMake(displayWidth, displayHeight)];
	}
}

- (void)cancelImageRequestOperation {
    [self.af_imageRequestOperation cancel];
    self.af_imageRequestOperation = nil;
}

@end

#pragma mark -

static inline NSString * AFImageCacheKeyFromURLRequest(NSURLRequest *request) {
    return [[request URL] absoluteString];
}

#endif
