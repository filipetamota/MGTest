//
//  AppDelegate.h
//  MGTest
//
//  Created by Filipe on 19/02/13.
//  Copyright (c) 2013 Filipe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navcon;

@end
