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

//handles OrderItemCount changing
- (IBAction)ClickOnStepper: (id)sender {
    if (_itemCountStepper.value == 0){
        /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Are you sure?"
                                                        message: @"Are you want to delete current item?"
                                                       delegate: self
                                              cancelButtonTitle: @"NO"
                                              otherButtonTitles: @"YES", nil
                              ];
        [alert show];*/
        UIAlertView *alert;
        [alert show];
    } else {
        [_itemCount setText: [NSString stringWithFormat: @"%d", (int)_itemCountStepper.value] ];
        _currentOrderItem.countOfItem = (int)_itemCountStepper.value;
        [_delegate redrawTable];
    }
}


////assign data to draw cell
- (void) drawCell
{
    _itemName.text          = _currentOrderItem.menuItemModel.name;
    _itemCount.text         = [NSString stringWithFormat:@"%d",_currentOrderItem.countOfItem];
    _itemCountStepper.value = _currentOrderItem.countOfItem;
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
