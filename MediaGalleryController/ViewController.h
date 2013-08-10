//
//  ViewController.h
//  MediaGallaryController
//
//  Created by ind360 on 12/19/12.
//  Copyright (c) 2012 ind360. All rights reserved.
//
                                                                   
#import <UIKit/UIKit.h>
#import "MGSlideShowView.h"

@interface ViewController : UIViewController <MGSlideShowViewDataSource,MGSlideShowViewDelegate>{

   IBOutlet MGSlideShowView *slideView;

}

@end
