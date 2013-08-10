//
//  MGPhoto.m
//  MediaGallaryController
//
//  Created by ind360 on 12/19/12.
//  Copyright (c) 2012 ind360. All rights reserved.
//

#import "MGPhotoView.h"

@interface MGPhotoView()

@property(nonatomic,retain)NSString        *urlString;
@property(nonatomic,retain)NSURLConnection *connection;
@property(nonatomic,retain)NSMutableData   *imageData;

@end

@implementation MGPhotoView
@synthesize urlString = _urlString, connection=_connection, imageData = _dataImg,placeHolderImage = _placeHolderImage;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
          
    }
    return self;
}

-(void)setImageWithURLString:(NSString*)string
{
    self.urlString = string;
    [self startDownloadingImage];
}

-(void)startDownloadingImage
{
    [self setImage:self.placeHolderImage];
    NSURL *aUrl = [NSURL URLWithString:_urlString];
    NSURLRequest *aRequest = [NSURLRequest requestWithURL:aUrl];
    [self.imageData setLength:0];
    self.imageData = nil;
    _dataImg = [[NSMutableData alloc]init];
    [self.connection cancel];
    self.connection = nil;
    _connection = [[NSURLConnection alloc]initWithRequest:aRequest delegate:self startImmediately:YES];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.imageData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.imageData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.imageData setLength:0];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *aImage = [UIImage imageWithData:self.imageData];
    [self setImage:aImage];
}

-(void)dealloc
{
    [self.connection cancel];
    MG_RELEASE(_connection);
    self.connection = nil;
    MG_RELEASE(_urlString);
    self.urlString = nil;
    MG_RELEASE(_dataImg);
    self.imageData = nil;
    MG_RELEASE(_placeHolderImage);
    self.placeHolderImage = nil;
    MG_SUPER_DEALLOC;
}

@end
