//
//  MGSlideShowController.m
//  MediaGallaryController
//
//  Created by ind360 on 12/19/12.
//  Copyright (c) 2012 ind360. All rights reserved.
//

#import "MGSlideShowView.h"
#import "MGScrollView.h"
#import "MGPhotoView.h"
#define C_Num 1001

@interface MGSlideShowView(){
    
    NSUInteger _fixtag;
    NSUInteger _currentTag;
    NSUInteger _totalImgs;
    CGRect     _rect;
}
@end

@implementation MGSlideShowView
@synthesize slideShowDataSource = _slideShowDataSource,slideShowDelegate = _slideShowDelegate,placeHolderImage = _placeHolderImage;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
       _rect   = [self frame];
    }
    return self;
}
- (void)setSlideShowDelegate:(id<MGSlideShowViewDelegate>)newSlideShowDelegate
{
    NSLog(@"called");
    if (newSlideShowDelegate) {
        _slideShowDelegate = newSlideShowDelegate;
    }
}
- (void)setSlideShowDataSource:(id<MGSlideShowViewDataSource>)newSlideShowDataSource
{

    if (newSlideShowDataSource) {
        _slideShowDataSource = newSlideShowDataSource;
        [self setUpViewWithIndex:0];
    }
}
- (id)initWithFrame:(CGRect)frame CurrentIndex:(NSUInteger)currentIndex DelegateAndDataSource:(id)controller
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.slideShowDataSource = controller;
        self.slideShowDelegate   = controller;
        
        [self setUpViewWithIndex:currentIndex];
     }
    return self;
}

-(void)setUpViewWithIndex:(NSUInteger)currentIndex
{
    NSLog(@"View frame:%@",NSStringFromCGRect(self.frame));
    _fixtag                  = currentIndex;
    _currentTag              = currentIndex;
    _rect.origin = CGPointMake(0, 0);
    
    UITapGestureRecognizer *aTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHandler:)];
    [aTapGesture setNumberOfTapsRequired:1];
    [self addGestureRecognizer:aTapGesture];
    MG_RELEASE(aTapGesture);
    
    _totalImgs = [self.slideShowDataSource numberOfImagesInSlideShowView:self];
    [self setContentSize:CGSizeMake(_rect.size.width*_totalImgs, _rect.size.height)];
    [self setPagingEnabled:YES];
    [self setDelegate:self];
    [self setContentOffset:CGPointMake(currentIndex*_rect.size.width, 0)];
    [self setPlaceHolderImage:[self.slideShowDataSource placeholderImageInSlideShowView:self]];
    
    int index = currentIndex?(currentIndex-1):currentIndex;
    
    _rect.origin = CGPointMake(index*_rect.size.width, _rect.origin.y);
    
    MGScrollView *aMediaView1 = [[MGScrollView alloc]initWithFrame:_rect];
    [self findImageForScrollView:aMediaView1 WhereIndexIs:index];
    
    _rect.origin = CGPointMake((1+index)*_rect.size.width, _rect.origin.y);
    
    MGScrollView *aMediaView2 = [[MGScrollView alloc]initWithFrame:_rect];
    [self findImageForScrollView:aMediaView2 WhereIndexIs:index+1];
    
    _rect.origin = CGPointMake((2+index)*_rect.size.width, _rect.origin.y);
    
    MGScrollView *aMediaView3 = [[MGScrollView alloc]initWithFrame:_rect];
    [self findImageForScrollView:aMediaView3 WhereIndexIs:index+2];
    
    [aMediaView1 setTag:C_Num+0+index];
    [aMediaView2 setTag:C_Num+1+index];
    [aMediaView3 setTag:C_Num+2+index];
    
    [self addSubview:aMediaView1];
    [self addSubview:aMediaView2];
    [self addSubview:aMediaView3];
    
    MG_RELEASE(aMediaView1);
    MG_RELEASE(aMediaView2);
    MG_RELEASE(aMediaView3);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSUInteger tagNo = (scrollView.contentOffset.x+(_rect.size.width/2))/_rect.size.width;
    [self scrollViewPagingDidChangeToTag:tagNo];    
}

-(void)scrollViewPagingDidChangeToTag:(NSUInteger)tagNo
{
    if(_currentTag!=tagNo) {
        if([self.slideShowDelegate respondsToSelector:@selector(slideShowView:willShowImageAtIndex:)])
            [self.slideShowDelegate slideShowView:self willShowImageAtIndex:tagNo];
    }
    
    if(_fixtag!=tagNo&&tagNo!=0&&tagNo<_totalImgs-1) {
        if(_fixtag<tagNo) {
            MGScrollView *tempView = (MGScrollView*)[self viewWithTag:C_Num+(tagNo-2)];
            if(tempView) {
                [tempView setTag:tagNo+C_Num+1];
                _rect.origin = CGPointMake((tagNo+1)*_rect.size.width, _rect.origin.y);
                [tempView setFrame:_rect];
                [self findImageForScrollView:tempView WhereIndexIs:tagNo+1];
            }
        }
        else {
            MGScrollView *tempView = (MGScrollView*)[self viewWithTag:C_Num+(tagNo+2)];
            if(tempView) {
                [tempView setTag:(tagNo-1)+C_Num];
                _rect.origin = CGPointMake((tagNo-1)*_rect.size.width, _rect.origin.y);
                [tempView setFrame:_rect];
                [self findImageForScrollView:tempView WhereIndexIs:tagNo-1];
            }
        }
        _fixtag = tagNo;
    }
    
    if(_currentTag!=tagNo) {
        _currentTag = tagNo;
        if([self.slideShowDelegate respondsToSelector:@selector(slideShowView:didShowImageAtIndex:)])
            [self.slideShowDelegate slideShowView:self didShowImageAtIndex:tagNo];
        for(UIScrollView*aView in self.subviews)
            if([aView isKindOfClass:[UIScrollView class]])
                [aView setZoomScale:aView.minimumZoomScale];
    }
 
}

-(void)tapHandler:(UITapGestureRecognizer*)gestureRecognizer
{
    [self.slideShowDelegate slideShowView:self userDidTapImageAtIndex:_currentTag];
}

-(void)findImageForScrollView:(MGScrollView*)scrollView WhereIndexIs:(NSUInteger)index
{
    if([self.slideShowDataSource respondsToSelector:@selector(slideShowView:imageUrlForIndex:)])
        [scrollView setImageWithURLString:[self.slideShowDataSource slideShowView:self imageUrlForIndex:index] PlaceHolderImage:self.placeHolderImage];
    else if([self.slideShowDataSource respondsToSelector:@selector(slideShowView:imageForIndex:)])
        [scrollView setImage:[self.slideShowDataSource slideShowView:self imageForIndex:index] placeHolderImage:self.placeHolderImage];
}

- (void)scrollForward
{
     NSUInteger tagNo = (self.contentOffset.x+(_rect.size.width/2))/_rect.size.width;
     tagNo++;
    [self scrollViewPagingDidChangeToTag:tagNo];  
    [self setContentOffset:CGPointMake(tagNo*_rect.size.width, 0) animated:YES];
}

- (void)scrollBackward
{
     NSUInteger tagNo = (self.contentOffset.x+(_rect.size.width/2))/_rect.size.width;
     tagNo--;
    [self scrollViewPagingDidChangeToTag:tagNo];
    [self setContentOffset:CGPointMake(tagNo*_rect.size.width, 0) animated:YES];
}

-(void)dealloc
{
    self.placeHolderImage = nil;
    MG_RELEASE(_placeHolderImage);
    MG_SUPER_DEALLOC;
}


@end
