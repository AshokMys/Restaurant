//
//  RestaurantDetailsView.h
//  Restaurant
//
//  Created by IMAC05 on 20/02/15.
//  Copyright (c) 2015 MYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AppDelegate.h"


@interface RestaurantDetailsView : UIViewController
{
    AppDelegate *appDelegate;
    
    IBOutlet UIScrollView *scrollView, *scrollFoodMenu, *scrollBarMenu, *scrollPhotos;
    
    IBOutlet UILabel *labelTopHeader;
    IBOutlet UIButton *btnBack;
    IBOutlet UIImageView *imageRestaurant;
    
    IBOutlet UILabel *labelRestaurantName, *labelAddress, *labelFoodType, *labelReviews, *labelRatings, *labelFullAddPlaceholder, *labelFullAd, *labelDistance;
    IBOutlet UIButton *btnEdit, *btnAddFavourite, *btnShare, *btnMakeCall, *btnWriteReview, *btnAllReviews;
    
    IBOutlet UIView *viewRestaurantName, *viewFoodMenu, *viewBarMenu, *viewPhotos;
    IBOutlet UILabel *labelFoodMenu, *labelBarMenu, *labelPhotos, *labelExpertReviewPlaceholder;
    
    IBOutlet MKMapView *mapView;
    IBOutlet UITableView *tableReviews;
    
    NSMutableArray *arrayFoodMenu, *arrayBarMenu, *arrayPhotos, *arrayReviews;
    
    BOOL isEnglish;
    
}


@end
