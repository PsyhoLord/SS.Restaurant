//
//  LocationViewController.h
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/18/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface LocationViewController : UIViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
