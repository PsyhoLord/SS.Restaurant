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

#import "Alert.h"

@implementation OrderItemCell

- (void) setDelegate: (id<POrderItems>) newDelegate
{
    _delegate = newDelegate;
}

//Setting properties
- (void) setDataWhithOrderItemModel:(OrderItemModel *)currentOrderItem andNumberOfRow:(int)row
{
    _currentOrderItem = currentOrderItem;
    _orderItemNumber  = row;
}


- (IBAction)clickOnStepper: (id)sender {
    if (_itemCountStepper.value == 0){
        [Alert showDeleteOrderItemWarningWithDelegate: self];
    } else {
        [_itemCount setText: [NSString stringWithFormat: @"%d", (int)_itemCountStepper.value] ];
        _currentOrderItem.amount = (int)_itemCountStepper.value;
        [_delegate redrawTable];
    }
}


////assign data to draw cell
- (void) drawCell
{
    _itemName.text          = _currentOrderItem.menuItemModel.name;
    _itemCount.text         = [NSString stringWithFormat:@"%d",_currentOrderItem.amount];
    _itemCountStepper.value = _currentOrderItem.amount;
    _pricePerPcs.text       =[ NSString stringWithFormat:@"%.2f $",_currentOrderItem.menuItemModel.price];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) alertView: (UIAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    // This method is invoked in response to the user's action. The altert view is about to disappear (or has been disappeard already - I am not sure)
    
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString: @"NO"]){
        _itemCountStepper.value ++;
        
    }
    else if([title isEqualToString: @"YES"]){
        [_delegate removeOrderItemAtIndex: _orderItemNumber];
    }
    
    [_delegate redrawTable];
    

}

@end
