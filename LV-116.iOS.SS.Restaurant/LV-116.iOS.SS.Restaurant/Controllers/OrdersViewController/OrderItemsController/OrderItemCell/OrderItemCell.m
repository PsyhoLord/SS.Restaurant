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
    
    double value = [_ItemCountStepper value];
   [ _ItemCount setText:[NSString stringWithFormat:@"%d",(int)value]];
     
    //NEED ADD ACTION WHEN COUNT=0
}

- (void)awakeFromNib
{
    // Initialization code
}




- (void) drawCellWithModel:(OrderItemModel*)orderItemModel
{
    _ItemName.text=orderItemModel.menuItemModel.name;
    _ItemCount.text=[NSString stringWithFormat:@"%d",orderItemModel.countOfItem];
    _ItemCountStepper.value=orderItemModel.countOfItem;
    _pricePerPcs.text=[NSString stringWithFormat:@"%f",orderItemModel.menuItemModel.price];
    
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self ) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"OrderItemCell" owner:self options:nil];
        self = [nibArray objectAtIndex:0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
