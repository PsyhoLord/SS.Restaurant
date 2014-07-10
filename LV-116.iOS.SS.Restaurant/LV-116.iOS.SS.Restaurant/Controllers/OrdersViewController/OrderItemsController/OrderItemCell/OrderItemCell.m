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



- (IBAction)ClickOnStepper:(id)sender {
    
    
    double value = [_itemCountStepper value];
    _currentOrderItem.countOfItem=(int)[_itemCountStepper value];
    [ _itemCount setText:[NSString stringWithFormat:@"%d",(int)value]];
    
    //NEED ADD ACTION WHEN COUNT=0
}

- (void)awakeFromNib
{
    // Initialization code
}




- (void) drawCell
{
    _itemName.text=_currentOrderItem.menuItemModel.name;
    _itemCount.text=[NSString stringWithFormat:@"%d",_currentOrderItem.countOfItem];
    _itemCountStepper.value=_currentOrderItem.countOfItem;
    _pricePerPcs.text=[NSString stringWithFormat:@"%.2f $",_currentOrderItem.menuItemModel.price];
    
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self ) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"OrderItemCell" owner:self options:nil];
        self = [nibArray objectAtIndex:0];
    }
    
    _currentOrderItem=[[OrderItemModel alloc] init];
    
    //Changing dimensions of stepper
    _itemCountStepper.transform=CGAffineTransformMakeScale(0.75, 1);
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
