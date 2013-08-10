//
//  MGSlideShowController.h
//  MediaGallaryController
//
//  Created by ind360 on 12/19/12.
//  Copyright (c) 2012 ind360. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGPhotoView.h"

@protocol MGSlideShowViewDataSource;
@protocol MGSlideShowViewDelegate;

@interface MGSlideShowView : UIScrollView <UIScrollViewDelegate>

- (id)initWithFrame:(CGRect)frame CurrentIndex:(NSUInteger)currentIndex DelegateAndDataSource:(id)controller;
- (void)scrollBackward;
- (void)scrollForward;

@property (nonatomic,MG_WEAK) IBOutlet  id<MGSlideShowViewDelegate> slideShowDelegate;
@property (nonatomic,MG_WEAK) IBOutlet  id<MGSlideShowViewDataSource> slideShowDataSource;
@property (nonatomic,MG_STRONG) UIImage* placeHolderImage;

@end


@protocol MGSlideShowViewDataSource <NSObject>

@required
- (NSUInteger)numberOfImagesInSlideShowView:(MGSlideShowView*)slideShowView;
- (UIImage*)placeholderImageInSlideShowView:(MGSlideShowView*)slideShowView;

@optional
- (NSString *)slideShowView:(MGSlideShowView*)slideShowView imageUrlForIndex:(NSUInteger)index;
- (UIImage*)slideShowView:(MGSlideShowView*)slideShowView imageForIndex:(NSUInteger)index;

@end


@protocol MGSlideShowViewDelegate <NSObject>

@optional
-(void)slideShowView:(MGSlideShowView*)slideShowView didShowImageAtIndex:(NSUInteger)index;
-(void)slideShowView:(MGSlideShowView*)slideShowView willShowImageAtIndex:(NSUInteger)index;
-(void)slideShowView:(MGSlideShowView*)slideShowView userDidTapImageAtIndex:(NSUInteger)index;

@end


