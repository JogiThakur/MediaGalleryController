//
//  MGPhoto.h
//  MediaGallaryController
//
//  Created by ind360 on 12/19/12.
//  Copyright (c) 2012 ind360. All rights reserved.
//

#if __has_feature(objc_arc)
#define MG_AUTORELEASE(exp) nil
#define MG_RELEASE(exp) nil
#define MG_RETAIN(exp) nil
#define MG_SUPER_DEALLOC nil
#else
#define MG_AUTORELEASE(exp) [exp autorelease]
#define MG_RELEASE(exp) [exp release]
#define MG_RETAIN(exp) [exp retain]
#define MG_SUPER_DEALLOC [super dealloc]
#endif

#ifndef MG_STRONG
#if __has_feature(objc_arc)
#define MG_STRONG strong
#else
#define MG_STRONG retain
#endif
#endif

#ifndef MG_WEAK
#if __has_feature(objc_arc_weak)
#define MG_WEAK weak
#elif __has_feature(objc_arc)
#define MG_WEAK unsafe_unretained
#else
#define MG_WEAK assign
#endif
#endif

#import <UIKit/UIKit.h>

@interface MGPhotoView : UIImageView <NSURLConnectionDataDelegate>

- (id)initWithFrame:(CGRect)frame ;
- (void)setImageWithURLString:(NSString*)string;

@property (nonatomic,MG_STRONG)UIImage* placeHolderImage;

@end
