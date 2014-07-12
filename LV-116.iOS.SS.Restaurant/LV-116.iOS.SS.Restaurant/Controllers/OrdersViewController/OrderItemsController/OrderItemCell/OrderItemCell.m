//
//  OrderItemCell.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/7/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "OrderItemCell.h"
#import "MenuItemModel.h"
#import "OrderItemModel.h"

@implementation OrderItemCell

- (void) setDelegate: (id<POrderItems>) newDelegate
{
    _delegate = newDelegate;
}


#warning - ClickOnStepper must be clickOnStepper

- (IBAction)ClickOnStepper: (id)sender {
    
    double value = [_itemCountStepper value];
    _currentOrderItem.countOfItem = (int)_itemCountStepper.value;
    [_itemCount setText: [NSString stringWithFormat: @"%d", (int)value] ];
    [_delegate redrawTable];
    
}


- (void) drawCell
{
    _itemName.text = _currentOrderItem.menuItemModel.name;
    _itemCount.text = [NSString stringWithFormat:@"%d",_currentOrderItem.countOfItem];
    _itemCountStepper.value = _currentOrderItem.countOfItem;
    _pricePerPcs.text =[ NSString stringWithFormat:@"%.2f $",_currentOrderItem.menuItemModel.price];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
