//
//  ImageTableViewCell.h
//  MGTest
//
//  Created by Filipe on 20/02/13.
//  Copyright (c) 2013 Filipe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTableViewCell : UITableViewCell {
    UILabel *primaryLabel;
    UILabel *secondaryLabel;
    UIImageView *image;
}


@property (nonatomic, retain) UILabel *primaryLabel;
@property (nonatomic, retain) UILabel *secondaryLabel;
@property (nonatomic, retain) UIImageView *image;
@property (nonatomic, retain) NSString *type;

@end