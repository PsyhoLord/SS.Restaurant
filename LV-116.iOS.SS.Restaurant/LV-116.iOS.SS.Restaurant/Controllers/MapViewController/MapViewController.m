//
//  MapViewController.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 6/21/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MapViewController.h"
#import "DataProvider.h"
#import "NavigationController.h"
#import "MapModel.h"
#import "TableModel.h"

@implementation MapViewController
{
    DataProvider *_dataProvider;
}

// create button with characteristic of the current TableModel
// (TableModel*)TableModel - model of one TableModel
// return button
-(UIButton*)setShapeButton:(TableModel*)TableModel
{
    if(TableModel.isActive){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button = [UIButton buttonWithType: UIButtonTypeCustom];
        button.frame = CGRectMake(TableModel.X, TableModel.Y, TableModel.height, TableModel.width);
        button.layer.borderWidth = 1;
        
        if(TableModel.isRound){
            button.layer.cornerRadius = 30;
        }
        if(TableModel.isFree){
            button.backgroundColor = [UIColor lightGrayColor];
        } else {
            button.backgroundColor = [UIColor redColor];
        }
        
        [button setTitle:[NSString stringWithFormat:@"%@",TableModel.name]
                forState:UIControlStateNormal];
        
        return button;
    } else {
        return nil;
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView.subviews objectAtIndex:0 ];
}

- (void)didFinishModelCreation
{
    // some code when MapModel has loaded from remote
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataProvider = ((NavigationController*)self.navigationController).dataProvider;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishModelCreation) name:notificationNameMapIsFinished object:_dataProvider];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 3.0f, scrollView.frame.size.height * 3.0f);
    scrollView.minimumZoomScale = 0.1f;
    scrollView.maximumZoomScale = 7.0f;
    
    UIView *zoomView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, scrollView.contentSize.width, scrollView.contentSize.height)];
    zoomView.backgroundColor = [UIColor whiteColor];
    
    MapModel *mapModel = [_dataProvider getMapData];
    
    for (TableModel *tableModel in mapModel.tableModelArray){
        [zoomView addSubview:[self setShapeButton:tableModel]];
    }
    
    [scrollView addSubview:zoomView];
    [self.view addSubview:scrollView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
