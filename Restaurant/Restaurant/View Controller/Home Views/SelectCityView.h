//
//  SelectCityView.h
//  Restaurant
//
//  Created by IMAC05 on 02/03/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SelectCityView : UIViewController <CLLocationManagerDelegate>
{
    
    AppDelegate *appDelegate;
    
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    
    IBOutlet UIButton *btnSkip;
    
    IBOutlet UILabel *labelTopHeader;
    
    IBOutlet UITextField *textSearch;
    IBOutlet UIButton *btnSearch, *btnAutoSearch, *btnBack;
    IBOutlet UITableView *tableCity;
    
    NSMutableArray *arrayCity, *arrayCountry;
    
    
    BOOL isEnglish;
    
}

@end
