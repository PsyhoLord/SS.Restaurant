//
//  OrderItemCell.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/7/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//


#import "POrderItems.h"

@class Alert;

@class MenuItemModel;
@class OrderItemModel;

@interface OrderItemCell : UITableViewCell <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel   *itemName;
@property (weak, nonatomic) IBOutlet UILabel   *itemCount;
@property (weak, nonatomic) IBOutlet UILabel   *pricePerPcs;
@property (weak, nonatomic) IBOutlet UIButton *amountButtonMinus;
@property (weak, nonatomic) IBOutlet UIButton *amountButtonPlus;

@property (weak,nonatomic) id <POrderItems> delegate;

@property (strong,nonatomic) OrderItemModel *currentOrderItem;
@property int orderItemNumber;

- (void) setDataWhithOrderItemModel: (OrderItemModel *) currentOrderItem andNumberOfRow:(int) row;
- (void) drawCell;

@end
