//
//  MGScrollView.h
//  MediaGallaryController
//
//  Created by ind360 on 12/19/12.
//  Copyright (c) 2012 ind360. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGPhotoView.h"

@interface MGScrollView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic,MG_STRONG) MGPhotoView *photoView;

- (id)initWithFrame:(CGRect)frame;
- (void)setImageWithURLString:(NSString*)urlString PlaceHolderImage:(UIImage*)placeHolder;
- (void)setImage:(UIImage*)image placeHolderImage:(UIImage*)placeHolder;

@end
