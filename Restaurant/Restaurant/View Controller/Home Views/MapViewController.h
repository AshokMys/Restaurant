//
//  MapViewController.h
//  Restaurant
//
//  Created by IMAC05 on 25/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <MapKit/MapKit.h>

#import <CoreLocation/CoreLocation.h>


@interface MapViewController : UIViewController <CLLocationManagerDelegate>
{
    AppDelegate *appDelegate;
    
    CLLocationCoordinate2D currentCoordinate;
    CLLocationManager *currentLocation;
    
    IBOutlet UILabel *labelTopHeader;
    IBOutlet UIButton *btnBack;
    
    IBOutlet MKMapView *mapView;

}

@end
