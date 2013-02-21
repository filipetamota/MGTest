//
//  RootViewController.h
//  MGTest
//
//  Created by Filipe on 19/02/13.
//  Copyright (c) 2013 Filipe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController{
    
}

@property (nonatomic, retain) NSArray *photoSet;
@property (nonatomic, retain) UITableView *tableView;
@property int numberTableElements;
@property (nonatomic, retain) UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, retain) UIView *footerView;
@property (nonatomic, retain) UIActivityIndicatorView *footerActivityIndicator;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

@end
