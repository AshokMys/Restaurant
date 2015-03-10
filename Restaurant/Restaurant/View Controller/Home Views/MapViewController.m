//
//  MapViewController.m
//  Restaurant
//
//  Created by IMAC05 on 25/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import "MapViewController.h"
#import "Constants.h"

#import "DDAnnotation.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    labelTopHeader.text = LocalizedString(@"map");
    labelTopHeader.font = [UIFont fontWithName:_roboto size:20];
    
    currentLocation = [[CLLocationManager alloc]init];
    currentLocation.desiredAccuracy = kCLLocationAccuracyBest;
    currentLocation.delegate = self;
    [currentLocation startUpdatingLocation];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
    //[appDelegate setNavigationController];
    
}



- (void)showAnnotation
{

    MKCoordinateRegion region;
    region.center = currentCoordinate;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    region.span=span;
   
    [mapView setRegion:region animated:TRUE];
    
    DDAnnotation *annotation = [[DDAnnotation alloc] initWithCoordinate:currentCoordinate addressDictionary:nil];
    [mapView addAnnotation:annotation];
    
}


#pragma mark Location Manager Event

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [currentLocation stopUpdatingLocation];
    currentCoordinate.latitude = newLocation.coordinate.latitude;
    currentCoordinate.longitude = newLocation.coordinate.longitude;
    
    [self showAnnotation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [currentLocation stopUpdatingLocation];
}



@end
