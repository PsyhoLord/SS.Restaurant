//
//  MapViewController.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 6/21/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "MapViewController.h"
#import "TableView.h"
#import "MapDataProvider.h"
#import "MapModel.h"
#import "TableModel.h"
#import "Alert.h"

@implementation MapViewController
{
    __weak IBOutlet UIScrollView *_scrollView;
    UIView          *_zoomView;
    UIImageView     *_backgroundView;
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
    
    [MapDataProvider loadMapDataWithBlock:^(MapModel *mapModel, NSError *error) {
        
        if ( error ) {
            dispatch_async( dispatch_get_main_queue(), ^{
                [Alert showConnectionAlert];
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            });
        } else {
            
            _mapModel = mapModel;
            
            [MapDataProvider loadMapBackgroundImageWithBlock:^(UIImage *mapBackgroundImage, NSError *error) {
                
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                
                dispatch_async( dispatch_get_main_queue(), ^{
                    if ( error ) {
                        [Alert showConnectionAlert];
                    } else {
                        _mapModel.image = mapBackgroundImage;
                        
                        // drawing map performs on main thread
                        [self drawMap];
                    }
                });
            }];
        }
    }];
    
}

// draw map view with all tables and background map image
- (void)drawMap
{
    _zoomView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _mapModel.image.size.width, _mapModel.image.size.height)];
    
    _backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _mapModel.image.size.width, _mapModel.image.size.height)];
    _backgroundView.image = _mapModel.image;
    
    [_zoomView addSubview:_backgroundView];
    
    for ( TableModel *tableModel in _mapModel.tableModelArray ) {
        [_zoomView addSubview:[self addTableView:tableModel]];
    }
    
    [_scrollView addSubview:_zoomView];
    
    _scrollView.contentSize = CGSizeMake(_mapModel.image.size.width, _mapModel.image.size.height);
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
