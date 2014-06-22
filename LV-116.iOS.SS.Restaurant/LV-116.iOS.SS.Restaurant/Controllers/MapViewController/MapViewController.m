//
//  MapViewController.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 6/21/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MapViewController.h"
#import "TableModel.h"

@implementation MapViewController
{
    __weak IBOutlet UIScrollView *_scrollView;
    UIButton *button;
    CGRect initialButtonFrame;
//    __weak IBOutlet UIImageView *_imageView;
}

// create button with characteristic of the current TableModel
// (TableModel*)TableModel - model of one TableModel
// return button
-(UIButton*)setShapeButton:(TableModel*)TableModel
{
    if(TableModel.isActive){
        button = [UIButton buttonWithType: UIButtonTypeCustom];
        button.frame = CGRectMake(TableModel.X, TableModel.Y, TableModel.height, TableModel.width);
        button.layer.borderWidth = 1;
        
        if(TableModel.isRound){
            button.layer.cornerRadius = 30;
        }
        if(TableModel.isFree){
            button.backgroundColor = [UIColor lightGrayColor];
        }else{
            button.backgroundColor = [UIColor redColor];
        }
        
        [button setTitle:[NSString stringWithFormat:@"%i",TableModel.capacity]
                forState:UIControlStateNormal];
        initialButtonFrame = button.frame;
        return button;
    } else{
        return nil;
    }
}


//-(void)scrollViewDidZoom:(UIScrollView *)scrollView
//{
//    CGPoint center = button.center;
//    CGPoint newCenter = center; //center is set at load time, and only once
//    newCenter.y = center.y * scrollView.zoomScale; //new center is calculated on original position
//    newCenter.x = center.x * scrollView.zoomScale;
//    button.center = newCenter;
//}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
//    return self.view.superview;
    return [_scrollView.subviews objectAtIndex:0 ];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    _scrollView.minimumZoomScale = 0.5;
    _scrollView.maximumZoomScale = 6.0;
    _scrollView.contentSize = CGSizeMake(1280, 960);
    _scrollView.delegate = self;
    
    // [self setShapeButton:TableModel] returns object of UIButton for add it to scrollView
//    [_scrollView addSubview:[self setShapeButton:tableModel]];
    [self.view addSubview: _scrollView];
    
//    [self.view addSubview: [self setShapeButton:TableModel]];
//    [self.view addSubview: [self setShapeButton:TableModel]];
    
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(150,120,50,50)];
//    UIImage *image = [UIImage imageNamed:@"UI_Arrow_2"];
//    [imageView setImage:image];
//    [button setImage:image forState:UIControlStateNormal];
//    [self.view addSubview:imageView];
//    [imgView drawInRect:CGRectMake(0,0,20,30)];
//    [_imageView setImage:imgView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
