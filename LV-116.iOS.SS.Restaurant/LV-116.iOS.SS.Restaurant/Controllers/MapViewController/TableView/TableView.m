//
//  TableView.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Roman Sorochak on 6/24/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "TableView.h"
#import "TableModel.h"

@implementation TableView
{
    __weak TableModel *_tableModel;
}

- (id)initWithTableModel:(TableModel*)tableModel
{
    self = [UIButton buttonWithType:UIButtonTypeCustom];
    if ( self ) {
        
        _tableModel = tableModel;
        
        self.frame = CGRectMake(_tableModel.X, _tableModel.Y, _tableModel.width, _tableModel.height);
        self.layer.borderWidth = 1;
        
        if ( _tableModel.isRound ) {
            self.layer.cornerRadius = 30;
        }
        if( _tableModel.rotation ){
            self.transform = CGAffineTransformMakeRotation(_tableModel.rotation * M_PI/180.0);
        }
        if ( _tableModel.isFree ) {
            self.backgroundColor = [UIColor lightGrayColor];
        } else {
            self.backgroundColor = [UIColor orangeColor];
        }
        [self setTitle:[NSString stringWithFormat:@"%@",_tableModel.name]
              forState:UIControlStateNormal];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
