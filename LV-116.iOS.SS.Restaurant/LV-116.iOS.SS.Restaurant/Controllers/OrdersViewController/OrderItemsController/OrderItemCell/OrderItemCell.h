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
@property (weak, nonatomic) IBOutlet UILabel *ItemName;
@property (weak, nonatomic) IBOutlet UILabel *ItemCount;
@property (weak, nonatomic) IBOutlet UIStepper *ItemCountStepper;
@property (weak, nonatomic) IBOutlet UILabel *pricePerPcs;

- (void) drawCellWithModel:(OrderItemModel*)orderItemModel;

@end
