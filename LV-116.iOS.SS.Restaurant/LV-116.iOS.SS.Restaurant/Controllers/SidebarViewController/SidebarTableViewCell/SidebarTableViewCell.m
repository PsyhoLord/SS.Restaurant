//
//  SidebarTableViewCell.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/8/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "SidebarTableViewCell.h"

static const CGFloat kHeightOfCell = 50.0f;

@implementation SidebarTableViewCell

@synthesize imageView = _imageView;

+ (CGFloat) rowHeightForCell
{
    return kHeightOfCell;
}

- (void) drawWithImage: (UIImage*)image text: (NSString*)text
{
    _imageView.image = image;
    _label.text = text;
}

- (void) setSelected: (BOOL)selected animated: (BOOL)animated
{
    [super setSelected: selected animated: animated];
    
    // Configure the view for the selected state
}

@end

