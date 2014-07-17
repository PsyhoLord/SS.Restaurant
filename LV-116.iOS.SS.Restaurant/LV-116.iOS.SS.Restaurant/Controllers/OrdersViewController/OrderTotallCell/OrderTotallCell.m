//
//  TotallOrderCell.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/8/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "OrderTotallCell.h"
#import "OrderModel.h"
#import "OrderItemModel.h"
#import "MenuItemModel.h"

@implementation OrderTotallCell

//setting delegate
- (void) setDelegate: (id<POrderItems>) newDelegate
{
    _delegate = newDelegate;
}

//calculating data to draw cell
- (void) drawCellWithModel: (OrderModel*)orderModel
{
    float totalValue = 0;
    
    for (int i = 0; i < [orderModel.arrayOfOrderItems count]; i++){
    
        OrderItemModel *itemInOrderWithCount;
        
        itemInOrderWithCount = [orderModel.arrayOfOrderItems objectAtIndex: i];
        
        totalValue += itemInOrderWithCount.menuItemModel.price * itemInOrderWithCount.amount;
    }
    
    self.totallPrice.text = [NSString stringWithFormat: @"Totall  %.2f$", totalValue];
}


//calling mathod in OrderItemsViewController
- (IBAction)addNewOrderItem: (UIButton *)sender {
    
    [_delegate sendUpdateOrder];
    
}


- (void)setSelected: (BOOL)selected animated: (BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
