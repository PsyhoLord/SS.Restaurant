//
//  LocationViewController.m
//  LV-116.iOS.SS.Restaurant
//
//  Created by Oleg Hnidets on 7/18/14.
//  Copyright (c) 2014 SortServe. All rights reserved.
//

#import "LocationViewController.h"
#import "SidebarViewController+ConfigurationForOtherViewControllers.h"

#import "Alert.h"


@implementation LocationViewController
{
    CLPlacemark *_thePlacemark;
    MKRoute *_routeDetails;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [SidebarViewController setupSidebarConfigurationForViewController: self
                                                        sidebarButton: self.sidebarButton
                                                            isGesture: NO];
    self.mapView.userLocation.title = @"You're Here";
}

- (IBAction)createRoute:(id)sender
{
    // geocoder saves street, city, state, and country information.
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:@"Washington" completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if ( error ) {
            NSLog(@"%@", error.description);
        } else {
            _thePlacemark = [placemarks lastObject];
            float spanX = 10.00725;
            float spanY = 10.00725;
            // A structure that defines which portion of the map to display.
            MKCoordinateRegion region;
            region.center.latitude = _thePlacemark.location.coordinate.latitude;
            region.center.longitude = _thePlacemark.location.coordinate.longitude;
            region.span = MKCoordinateSpanMake(spanX, spanY);
            
            [self.mapView setRegion:region animated:YES];
            [self addAnnotation: _thePlacemark];
            
            MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:_thePlacemark];
            // Create request for getting the start and the end points.
            MKDirectionsRequest *directionsRequest = [[MKDirectionsRequest alloc] init];
            // The map item that represents the starting point for routing directions.
            [directionsRequest setSource:[MKMapItem mapItemForCurrentLocation]];
            // Sets the end point for routing directions.
            [directionsRequest setDestination:[[MKMapItem alloc] initWithPlacemark:placemark]];
            directionsRequest.transportType = MKDirectionsTransportTypeAutomobile;
            
            // This class can saves direction that based on directionsRequest.
            MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
            // Begins calculating the requested route information asynchronously.
            [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
                
                if ( error ) {
                    NSLog(@"Error %@", error.description);
                } else {
                    //  _routeDetails defines the geometry for the route and includes information which you can display to the user.
                    _routeDetails = response.routes.lastObject;
                    
                    [self.mapView addOverlay: _routeDetails.polyline level:MKOverlayLevelAboveRoads];
                    
                }
            }];
        }
    }];

}

// Adds point annotation using placemark.
- (void)addAnnotation:(CLPlacemark *)placemark {
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = CLLocationCoordinate2DMake(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude);
    point.title = [placemark.addressDictionary objectForKey: @"Street"];
    [self.mapView addAnnotation:point];
}

// Adds on map route line.
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer  * routeLineRenderer = [[MKPolylineRenderer alloc] initWithPolyline:_routeDetails.polyline];
    routeLineRenderer.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    routeLineRenderer.lineWidth = 3;
    return routeLineRenderer;
}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if ( [annotation isKindOfClass:[MKUserLocation class]] )
        return nil;
    
    // Handle any custom annotations.
    if ( [annotation isKindOfClass:[MKPointAnnotation class]] ) {
        // Try to dequeue an existing pin view first.
        MKPinAnnotationView *pinView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if ( !pinView )  {
            // If an existing pin view was not available, create one.
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            pinView.canShowCallout = YES;
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    [self.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
}

@end
