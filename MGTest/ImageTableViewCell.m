//
//  ImageTableViewCell.m
//  MGTest
//
//  Created by Filipe on 20/02/13.
//  Copyright (c) 2013 Filipe. All rights reserved.
//

#import "ImageTableViewCell.h"

@implementation ImageTableViewCell

@synthesize primaryLabel, secondaryLabel, image, type;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if([reuseIdentifier isEqualToString:@"ImageTableViewCell_Landscape"]){
            self.type = @"Landscape";
        } else {
            self.type = @"Portrait";
        }
        // Initialization code
        primaryLabel = [[UILabel alloc]init];
        primaryLabel.textAlignment = NSTextAlignmentLeft;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            primaryLabel.font = [UIFont boldSystemFontOfSize:16];
        } else {
            primaryLabel.font = [UIFont boldSystemFontOfSize:20];
        }
       
        secondaryLabel = [[UILabel alloc]init];
        secondaryLabel.textAlignment = NSTextAlignmentLeft;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            secondaryLabel.font = [UIFont systemFontOfSize:10];
        } else {
            secondaryLabel.font = [UIFont systemFontOfSize:15];
        }
        
        image = [[UIImageView alloc]init];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:primaryLabel];
        [self.contentView addSubview:secondaryLabel];
        [self.contentView addSubview:image];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        frame= CGRectMake(boundsX+10 ,5, 50, 50);

    } else {
        frame= CGRectMake(boundsX+10 ,5, 90, 90);

    }
    image.frame = frame;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if([self.type isEqualToString:@"Portrait"]){
            frame= CGRectMake(boundsX+70 ,5, 250, 25);
        } else {
            frame= CGRectMake(boundsX+70 ,5, 350, 25);
        }
    } else {
        if([self.type isEqualToString:@"Portrait"]){
            frame= CGRectMake(boundsX+120 ,20, 500, 25);
        } else {
            frame= CGRectMake(boundsX+120 ,20, 700, 25);
        }
    }
    primaryLabel.frame = frame;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if([self.type isEqualToString:@"Portrait"]){
            frame= CGRectMake(boundsX+75 ,30, 150, 15);
        } else {
            frame= CGRectMake(boundsX+75 ,30, 200, 15);
        }
    } else {
        if([self.type isEqualToString:@"Portrait"]){
            frame= CGRectMake(boundsX+125 ,50, 400, 15);
        } else {
            frame= CGRectMake(boundsX+125 ,50, 600, 15);
        }
    }

    
    secondaryLabel.frame = frame;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
