//
//  TotallOrderCell.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Mykola_Salo on 7/8/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderModel;
@class MenuItemModel;

@interface OrderTotallCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *TotallPrice;

- (IBAction)AddNewOrderItem:(UIButton *)sender;

- (void) drawCellWithModel:(OrderModel*)orderModel;

@end
