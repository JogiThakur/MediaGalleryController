//
//  MGScrollView.m
//  MediaGallaryController
//
//  Created by ind360 on 12/19/12.
//  Copyright (c) 2012 ind360. All rights reserved.
//

#import "MGScrollView.h"
#import "MGPhotoView.h"

@implementation MGScrollView
@synthesize photoView = _photoView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@" frame origin -- %f",frame.origin.x);
    }
    return self;
}

-(void)setImageWithURLString:(NSString*)urlString PlaceHolderImage:(UIImage*)placeHolder
{
    if(!self.photoView) {
        _photoView = [[MGPhotoView alloc]initWithFrame:self.bounds];
        self.photoView.placeHolderImage = placeHolder;
        [self.photoView setImageWithURLString:urlString];
        [self startUpOperations];
    }
    else {
        [self.photoView setImageWithURLString:urlString];
    }
}

-(void)setImage:(UIImage*)image placeHolderImage:(UIImage*)placeHolder
{
     if(!self.photoView) {
         _photoView = [[MGPhotoView alloc]initWithFrame:self.bounds];
         self.photoView.placeHolderImage = placeHolder;
         [self.photoView setImage:image];
         [self startUpOperations];
     }
     else {
        [self.photoView setImage:image];
     }
}

//-(void)setNewFrame:(CGRect)frame WithImageURLString:(NSString*)urlString
//{
//    [self setFrame:frame];
//    [self.photoView setImageWithURLString:urlString];
//}
//
//-(void)setNewFrame:(CGRect)frame WithImage:(UIImage*)image
//{
//    [self setFrame:frame];
//    [self.photoView setImage:image];
//}

- (void)startUpOperations
{
    [self addSubview:_photoView];
    [self centerScrollViewContents:self];
    [self setDelegate:self];
    [self setMinimumZoomScale:1];
    [self setMaximumZoomScale:2];
    [self setZoomScale:self.minimumZoomScale];
    [self setBounces:NO];
}

#pragma mark - scrollview delegated

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.photoView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self centerScrollViewContents:scrollView];
}

- (void)centerScrollViewContents:(UIScrollView*)scrollView
{
    CGSize boundsSize = scrollView.bounds.size;
    CGRect contentsFrame = self.photoView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.photoView.frame = contentsFrame;
}

-(void)dealloc
{
    self.photoView = nil;
    MG_RELEASE(_photoView);
    MG_SUPER_DEALLOC;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
