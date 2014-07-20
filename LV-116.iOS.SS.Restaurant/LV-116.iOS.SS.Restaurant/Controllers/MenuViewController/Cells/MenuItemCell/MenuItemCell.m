//
//  ItemCell.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Kristina on 26.06.14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MenuItemCell.h"
#import "MenuDataProvider.h"
#import "MenuItemModel.h"
#import "Alert.h"


@implementation MenuItemCell

// This method draw cell with data from menuItemModel
// (MenuItemModel*)menuItemModel - data for cell
- (void) drawCellWithModel: (MenuItemModel*)menuItemModel
{
    _itemName.text        = menuItemModel.name;
    _itemPrice.text       = [NSString stringWithFormat:@"%.2f$", menuItemModel.price];
    
    if ( menuItemModel.image ) {
        _itemImage.image = menuItemModel.image;
    } else {
         
        [MenuDataProvider loadMenuItemImage:menuItemModel withBlock:^(UIImage *itemImage, NSError *error) {
            
            if ( error ) {
            //   [Alert showConnectionAlert];
            } else {
                menuItemModel.image = itemImage;
                
                // drawing of item image performs on main thread.
                dispatch_async( dispatch_get_main_queue(), ^{
                    if (itemImage) {
                    _itemImage.image = itemImage;
                    }
                } );
            }
        }];
        
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}



@end
