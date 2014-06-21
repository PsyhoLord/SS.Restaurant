//
//  MapViewController.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 6/21/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MapViewController.h"
#import "Table.h"

@implementation MapViewController
{
    __weak IBOutlet UIScrollView *_scrollView;
    UIButton *button;
    CGRect initialButtonFrame;
//    __weak IBOutlet UIImageView *_imageView;
}

// create button with characteristic of the current table
// (Table*)table - model of one table
// return button
-(UIButton*)setShapeButton:(Table*)table
{
    if(table.isActive){
        button = [UIButton buttonWithType: UIButtonTypeCustom];
        button.frame = CGRectMake(table.X, table.Y, table.height, table.width);
        button.layer.borderWidth = 1;
        
        if(table.isRound){
            button.layer.cornerRadius = 30;
        }
        if(table.isFree){
            button.backgroundColor = [UIColor lightGrayColor];
        }else{
            button.backgroundColor = [UIColor redColor];
        }
        
        [button setTitle:[NSString stringWithFormat:@"%i",table.capacity]
                forState:UIControlStateNormal];
        initialButtonFrame = button.frame;
        return button;
    } else{
        return nil;
    }
}


//-(void)scrollViewDidZoom:(UIScrollView *)scrollView
//{
//    button.frame = CGRectMake((initialButtonFrame.origin.x * scrollView.zoomScale),
//                                   (initialButtonFrame.origin.y * scrollView.zoomScale),
//                                   initialButtonFrame.size.width,
//                                   initialButtonFrame.size.height);
//}

//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//    button.frame = CGRectMake(679, 120, 50, 100);
//    return button;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // create object of class Table for use it to build tables map
    Table *table = [[Table alloc] initWithCapacity:2 height:62 width:58 coordX:67 coordY:120 isFree:true isActive:true isRound:true];
    
    //
    _scrollView.minimumZoomScale=0.5;
    _scrollView.maximumZoomScale=6.0;
    _scrollView.contentSize=CGSizeMake(1280, 960);
    _scrollView.delegate = self;
    
    // [self setShapeButton:table] returns object of UIButton for add it to scrollView
    [_scrollView addSubview:[self setShapeButton:table]];
    
//    [self.view addSubview: [self setShapeButton:table]];
//    [self.view addSubview: [self setShapeButton:table]];
    
    
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
