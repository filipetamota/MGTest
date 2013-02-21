//
//  RootViewController.m
//  MGTest
//
//  Created by Filipe on 19/02/13.
//  Copyright (c) 2013 Filipe. All rights reserved.
//

#import "RootViewController.h"
#import "FlickrAPI.h"
#import "ImageTableViewCell.h"
#import "ImageViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define TABLEVIEW_CELL_HEIGHT 44.0

@interface RootViewController ()

@end

@implementation RootViewController

@synthesize photoSet, tableView=_tableView, numberTableElements, loadingIndicator=_loadingIndicator, footerView=_footerView, footerActivityIndicator;

@synthesize activityIndicator=_activityIndicator;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityIndicator setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin];
    [activityIndicator setCenter:[[self view] center]];
    [activityIndicator startAnimating];
    [self setActivityIndicator:activityIndicator];
    [activityIndicator release];
    
    [[self view] addSubview:[self activityIndicator]];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:backButton];
    [backButton release];
    
    self.numberTableElements = 20;
    
}

-(void)viewDidAppear:(BOOL)animated{
    FlickrAPI *flickr = [[FlickrAPI alloc] init];
    NSString *userId = [flickr userIdForUserName:@"vulture labs"];
    NSArray *photoSets = [flickr photoSetListWithUserId:userId];
    NSString *photoSetId = [flickr photoSetIdWithTitle:@"My Faves" photoSets:photoSets];
    self.photoSet = [NSArray array];
    self.photoSet = [flickr photosWithPhotoSetId:photoSetId];
    [flickr release];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%d images", [photoSet count]];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = (id) self;
    tableView.delegate = (id) self;
    self.tableView = tableView;
    [tableView release];
    [self.view addSubview:self.tableView];
    
    //creates the view and the indicator for the "load more" feature
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 480, 44)];
    UIActivityIndicatorView *loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        loadingIndicator.center = CGPointMake(160, 22);
        if(self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight){
            loadingIndicator.center = CGPointMake(240, 22);
        }
    } else {
        loadingIndicator.center = CGPointMake(384, 22);
        if(self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight){
            loadingIndicator.center = CGPointMake(512, 22);
        }
    }

    
    loadingIndicator.hidesWhenStopped = NO;
    self.loadingIndicator=loadingIndicator;
    [loadingIndicator release];
    [footerView addSubview:self.loadingIndicator];
    self.footerView=footerView;
    [footerView release];
    
    
    self.footerActivityIndicator=self.loadingIndicator;
    [[self tableView] setTableFooterView:[self footerView]];
    
    //hide the header
    [self.tableView setContentOffset:CGPointMake(0, 1*TABLEVIEW_CELL_HEIGHT)];
    
    [[self activityIndicator] stopAnimating];

}

- (void)viewDidUnload {
    [self.photoSet release];
    self.photoSet = nil;
    [self.tableView release];
    self.tableView = nil;
    [self.activityIndicator release];
    self.activityIndicator = nil;
    [self.loadingIndicator release];
    self.loadingIndicator = nil;
    [self.footerView release];
    self.footerView = nil;
    [self.footerActivityIndicator release];
    self.footerActivityIndicator = nil;
}

- (void)dealloc {
    [self.photoSet release];
    self.photoSet = nil;
    [self.tableView release];
    self.tableView = nil;
    [self.activityIndicator release];
    self.activityIndicator = nil;
    [self.loadingIndicator release];
    self.loadingIndicator = nil;
    [self.footerView release];
    self.footerView = nil;
    [self.footerActivityIndicator release];
    self.footerActivityIndicator = nil;
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    self.tableView.frame = self.view.frame;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [self.tableView reloadData];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if(self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight){
            self.loadingIndicator.center = CGPointMake(240, 22);
        } else {
            self.loadingIndicator.center = CGPointMake(160, 22);
        }
    } else {
        if(self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight){
            self.loadingIndicator.center = CGPointMake(512, 22);
        } else {
            self.loadingIndicator.center = CGPointMake(384, 22);
        }
    }

}


#pragma mark - UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([self.photoSet count] > self.numberTableElements){
        if (([scrollView contentOffset].y + scrollView.frame.size.height) == [scrollView contentSize].height) {
            [[self footerActivityIndicator] startAnimating];
            [self performSelector:@selector(stopAnimatingFooter) withObject:nil afterDelay:0.5];
            return;
        }
    }
 
}

//stop the footer spinner
- (void) stopAnimatingFooter{
    [[self footerActivityIndicator] stopAnimating];
    self.numberTableElements = self.numberTableElements + 20;
    if(self.numberTableElements >= [self.photoSet count]){
        self.numberTableElements = [self.photoSet count];
        [self.loadingIndicator removeFromSuperview];
        self.tableView.tableFooterView.hidden = YES;
    }
    [self.tableView reloadData];
}

#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.numberTableElements;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return 60;
    } else {
        return 100;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier;
    if(self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight){
        CellIdentifier = @"ImageTableViewCell_Landscape";
    } else {
        
        CellIdentifier = @"ImageTableViewCell_Portrait";
    }
    
    ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[ImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell = [[ImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.primaryLabel.text = [[NSString alloc] initWithFormat:@"Image %d - %@", indexPath.row+1, [[photoSet objectAtIndex:indexPath.row] objectForKey:@"title"]];
    cell.secondaryLabel.text = [[NSString alloc] initWithFormat:@"ID: %@", [[photoSet objectAtIndex:indexPath.row] objectForKey:@"id"]];
    [cell.image setImageWithURL:[NSURL URLWithString:[[photoSet objectAtIndex:indexPath.row] objectForKey:@"url_t"]]
                       placeholderImage:[UIImage imageNamed:@"photoDefault.png"]];

    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ImageViewController *ivc = [[ImageViewController alloc] init];
    ivc.photo = [photoSet objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:ivc animated:YES];
    [ivc release];
}

-(UIImage*)imageFromURL:(NSString*)url{
    if ([url isEqual:@""]) {
        return nil;
    } else {
        NSData * imageData = [[[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:url]] autorelease];
        return [UIImage imageWithData:imageData];
    }
}


@end
