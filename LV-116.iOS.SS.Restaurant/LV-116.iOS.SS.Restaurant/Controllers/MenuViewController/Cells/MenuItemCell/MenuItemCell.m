//
//  ItemCell.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Kristina on 26.06.14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MenuItemCell.h"
#import "DataProvider.h"
#import "MenuItemModel.h"
#import "Alert.h"
#import "DescriptionScreen.h"

#define CELL_HEIGHT 107

@implementation MenuItemCell


+ (CGFloat) rowHeightForCell
{
    return CELL_HEIGHT;
}

//{static int Height;}
@synthesize delegate = _delegate;

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.delegate = nil;
}

- (void)awakeFromNib
{
    // Initialization code
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"MenuItemCell" owner:self options:nil];
        self = [nibArray objectAtIndex:0];
    }
    return self;
}


// This method draw cell with data from menuItemModel
// (MenuItemModel*)menuItemModel - data for cell
- (void)drawCellWithModel:(MenuItemModel*)menuItemModel
{
    _itemName.text        = menuItemModel.name;
    _itemDescription.text = menuItemModel.description;
    _itemPrice.text       = [NSString stringWithFormat:@"%.2f$", menuItemModel.price];
    _itemWeight.text      = [NSString stringWithFormat:@"%ldg",menuItemModel.portions];
    
    if ( menuItemModel.image ) {
        
        _itemImage.image = menuItemModel.image;
        
    } else {
        
        [DataProvider loadMenuItemImage:menuItemModel withBlock:^(UIImage *itemImage, NSError *error) {
            
            if ( error ) {
//                [Alert showConnectionAlert];
            } else {
                menuItemModel.image = itemImage;
                
                _itemImage.image = itemImage;
            }
        }];
        
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
- (IBAction)InfoButtonPressed:(id)sender {
    if ([self.delegate respondsToSelector:@selector(delegateForCell:)])
        [self.delegate delegateForCell:self];
}

@end
