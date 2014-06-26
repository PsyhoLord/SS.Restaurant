//
//  MapViewController.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 6/21/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "NavigationController.h"
#import "MapViewController.h"
#import "TableView.h"
#import "DataProvider.h"
#import "MapModel.h"
#import "TableModel.h"

static const CGFloat scrollViewMinimumZoomScale      = 0.6f;
static const CGFloat scrollViewMaximumZoomScale      = 7.0f;

@implementation MapViewController
{
    __weak IBOutlet UIScrollView *_scrollView;
    UIView          *_zoomView;
    DataProvider    *_dataProvider;
    MapModel        *_mapModel;
    NSMutableArray  *_tableViews;
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
- (void)getMapDataFromModel
{
    // get an pointer to an object of model
    _dataProvider = ((NavigationController*)self.navigationController).dataProvider;
    _mapModel = [_dataProvider getMapData];
    if ( _mapModel ) {
        [self drawMap];
    }
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
        [self addTableView:tableModel];
        [_zoomView addSubview:[self addTableView:tableModel]];
    }
    
    [_scrollView addSubview:_zoomView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView.subviews objectAtIndex:0 ];
}

// called by NSNotificationCenter if is notificationNameMapIsFinished
- (void)didFinishMapModelCreation
{
    _mapModel = [_dataProvider getMapData];
    [self drawMap];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // init _tableViews
    _tableViews = [[NSMutableArray alloc] init];
    
    // add self as observer to a notificationNameMapIsFinished from model
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishMapModelCreation) name:notificationMapModelIsFinished object:_dataProvider];
    
    [self getMapDataFromModel];
}

// remove self as observer from NSNotificationCenter when it deallocate
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
