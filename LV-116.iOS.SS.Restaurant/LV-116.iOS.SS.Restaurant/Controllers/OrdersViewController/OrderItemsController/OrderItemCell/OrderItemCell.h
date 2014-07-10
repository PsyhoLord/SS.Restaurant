//
//  OrderItemCell.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/7/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuItemModel;
@class OrderItemModel;

@interface OrderItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UILabel *itemCount;
@property (weak, nonatomic) IBOutlet UILabel *pricePerPcs;
@property (weak, nonatomic) IBOutlet UIStepper *itemCountStepper;





@property (strong,nonatomic) OrderItemModel *currentOrderItem;

- (void) drawCell;

@end
