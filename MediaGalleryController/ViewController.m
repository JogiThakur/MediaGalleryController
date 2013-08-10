//
//  ViewController.m
//  MediaGallaryController
//
//  Created by ind360 on 12/19/12.
//  Copyright (c) 2012 ind360. All rights reserved.
//

#import "ViewController.h"
#import "MGPhotoView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    slideView.slideShowDataSource = self;
    slideView.slideShowDelegate = self;
    
//    slideView = [[MGSlideShowView alloc]initWithFrame:self.view.bounds CurrentIndex:2 DelegateAndDataSource:self];
//    [slideView setBackgroundColor:[UIColor blackColor]];
//    [self.view addSubview:slideView];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - MGSlideShowController DataSource and Delegated Methods

-(UIImage*)placeholderImageInSlideShowView:(MGSlideShowView*)slideShowView
{
    return [UIImage imageNamed:@"placeholder.png"];
}

-(NSUInteger)numberOfImagesInSlideShowView:(MGSlideShowView*)slideShowView
{
    return 5;
}

-(NSString *)slideShowView:(MGSlideShowView*)slideShowView imageUrlForIndex:(NSUInteger)index
{
    return @"http://images.mathrubhumi.com/english_images/2012/Dec/06/03082_185786.jpg";
}

//-(UIImage *)slideShowView:(MGSlideShowView *)slideShowView imageForIndex:(NSUInteger)index
//{
//    return [UIImage imageNamed:@"PlaceHolder.jpg"];
//}

-(void)dealloc
{
    // just commented data
    [slideView release];
    [super dealloc];
}

-(void)slideShowView:(MGSlideShowView *)slideShowView didShowImageAtIndex:(NSUInteger)index
{
    NSLog(@" didindex ------ %d",index);
}

-(void)slideShowView:(MGSlideShowView *)slideShowView willShowImageAtIndex:(NSUInteger)index
{
    NSLog(@" willindex ------ %d",index);
}

-(void)slideShowView:(MGSlideShowView *)slideShowView userDidTapImageAtIndex:(NSUInteger)index
{
    NSLog(@"user did tap");
}


@end
