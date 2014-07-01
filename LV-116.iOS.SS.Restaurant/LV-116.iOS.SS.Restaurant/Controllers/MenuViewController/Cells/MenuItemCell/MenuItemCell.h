//
//  ItemCell.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Kristina on 26.06.14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

// class menuItemCell needs for custom item cell
#import "PMenuItemCell.h"
@class MenuItemModel;
@protocol MenuItemCellDelegate;

@interface MenuItemCell : UITableViewCell//<PMenuItemCell>

@property (weak, nonatomic) IBOutlet UILabel     *itemName;
@property (weak, nonatomic) IBOutlet UILabel     *itemDescription;
@property (weak, nonatomic) IBOutlet UILabel     *itemPrice;
@property (weak, nonatomic) IBOutlet UILabel     *itemWeight;
@property (weak, nonatomic) IBOutlet UIImageView *itemImage;
@property (weak, nonatomic) id <MenuItemCellDelegate> delegate;


// this method draw cell with data from menuItemModel
// (MenuItemModel*)menuItemModel - data for cell
- (void)drawCellWithModel:(MenuItemModel*)menuItemModel;


+ (CGFloat) rowHeightForCell;

@end

@protocol MenuItemCellDelegate <NSObject>

@optional

- (void)delegateForCell:(MenuItemCell *)cell;
@end
