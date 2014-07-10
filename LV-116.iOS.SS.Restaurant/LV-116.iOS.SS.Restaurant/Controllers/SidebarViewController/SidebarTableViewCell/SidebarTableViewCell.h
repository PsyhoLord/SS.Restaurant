//
//  SidebarTableViewCell.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 7/8/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

@interface SidebarTableViewCell : UITableViewCell
@property (weak, nonatomic, readonly) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

- (void) drawWithImage: (UIImage*)image text: (NSString*)text;

+ (CGFloat) rowHeightForCell;

@end
