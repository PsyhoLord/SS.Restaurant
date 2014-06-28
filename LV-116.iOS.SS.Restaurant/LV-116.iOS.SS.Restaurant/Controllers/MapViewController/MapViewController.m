//
//  MapViewController.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 6/21/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MapViewController.h"
#import "TableView.h"
#import "DataProvider.h"
#import "MapModel.h"
#import "TableModel.h"
#import "Alert.h"

static const CGFloat scrollViewMinimumZoomScale      = 0.6f;
static const CGFloat scrollViewMaximumZoomScale      = 3.0f;

@implementation MapViewController
{
    __weak IBOutlet UIScrollView *_scrollView;
    UIView          *_zoomView;
//    DataProvider    *_dataProvider;
    MapModel        *_mapModel;
    NSMutableArray  *_tableViews;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // init _tableViews
    _tableViews = [[NSMutableArray alloc] init];
    
    [self loadMapData];
}

// create button with characteristic of the current TableModel
// (TableModel*)TableModel - model of one TableModel
// return button
- (TableView*)addTableView:(TableModel*)tableModel
{
    if ( tableModel.isActive ){
        TableView *tableView = [[TableView alloc] initWithTableModel:tableModel];
        [_tableViews addObject:tableView];
        return tableView;
    } else {
        return nil;
    }
}

// get map data from model
// if there is no data than dataProvider get it from server
// and post noteification after get it
- (void)loadMapData
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [DataProvider loadMapDataWithBlock:^(MapModel *mapModel, NSError *error) {
        
        if ( error ) {
            [Alert showConnectionAlert];
        } else {
            
            _mapModel = mapModel;
            
            [DataProvider loadMapBackgroundImageWithBlock:^(UIImage *mapBackgroundImage, NSError *error) {
               
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                
                if ( error ) {
                    [Alert showConnectionAlert];
                } else {
                    _mapModel.image = mapBackgroundImage;
                    [self drawMap];
                }

            }];
        }
        
    }];
}

// draw map view with all tables and background map image
- (void)drawMap
{
    _scrollView.contentSize = CGSizeMake(_mapModel.image.size.width, _mapModel.image.size.height);

    _scrollView.minimumZoomScale = scrollViewMinimumZoomScale;
    _scrollView.maximumZoomScale = scrollViewMaximumZoomScale;
    
    _zoomView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _mapModel.image.size.width, _mapModel.image.size.height)];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _mapModel.image.size.width, _mapModel.image.size.height)];
    backgroundView.image = _mapModel.image;
    
    [_zoomView addSubview:backgroundView];
    
    for ( TableModel *tableModel in _mapModel.tableModelArray ) {
        [_zoomView addSubview:[self addTableView:tableModel]];
    }
    
    [_scrollView addSubview:_zoomView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView.subviews objectAtIndex:0 ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
