//
//  ImageViewController.m
//  MGTest
//
//  Created by Filipe on 19/02/13.
//  Copyright (c) 2013 Filipe. All rights reserved.
//

#import "ImageViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>

@interface ImageViewController ()

@end

@implementation ImageViewController

@synthesize photo, scrollView=_scrollView, imageView=_imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    self.navigationItem.title = [self.photo objectForKey:@"title"];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    if(self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight){
        scrollView.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
    }
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = NO;
    scrollView.directionalLockEnabled = YES;
    scrollView.bounces = NO;
    scrollView.bouncesZoom = YES;
    scrollView.delaysContentTouches = YES;
    scrollView.canCancelContentTouches = YES;
    scrollView.minimumZoomScale=1.0;
    scrollView.maximumZoomScale=6.0;
    scrollView.contentSize=scrollView.frame.size;
    scrollView.delegate=(id)self;
    self.scrollView = scrollView;
    [scrollView release];

    
    UIImageView *imageView = [[UIImageView alloc] init];
    
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    if(self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight){
        imageView.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
    }
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setImageWithURL:[NSURL URLWithString:[photo objectForKey:@"url_m"]] placeholderImage:[UIImage imageNamed:@"photoDefault.png"]];
    self.imageView = imageView;
    [imageView release];
    
    [self.scrollView addSubview:self.imageView];
    
    [self.view addSubview:self.scrollView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    self.scrollView.frame = self.view.frame;
    self.scrollView.contentSize=self.scrollView.frame.size;
    self.imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


@end
